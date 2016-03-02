require 'tilt'
class Rack::App::FrontEnd::Template
  NO_LAYOUT_KEYWORD = :none

  require 'rack/app/front_end/template/default_layout'
  require 'rack/app/front_end/template/default_template'

  def self.cache
    @cache ||= Tilt::Cache.new
  end

  def render(scope, *args, &block)
    extend_with_helpers(scope)

    layout(scope).render(scope, *args) { template.render(scope, *args, &block) }
  end

  protected

  def initialize(template_path, klass)
    @file_path = template_path
    @class = klass
  end

  def is_a_template?
    not Tilt.templates_for(@file_path).empty?
  end

  def template
    if is_a_template?
      get_template(@file_path)
    else
      DefaultTemplate.new(@file_path)
    end
  end

  def layout(scope)
    return DefaultLayout if use_default_layout?(scope)
    block_layouts_for(scope)
    get_template(@class.layout)
  end


  def use_default_layout?(scope)
    (scope.instance_variable_get(:@layout) == NO_LAYOUT_KEYWORD) or
        (@class.respond_to?(:layout) and @class.layout.nil?) or
        (@file_path =~ /^#{Regexp.escape(Rack::App::Utils.namespace_folder(@class.layout))}/)
  end

  def get_template(file_path)
    self.class.cache.fetch(file_path) { Tilt.new(file_path, template_options) }
  end

  def template_options
    @class.template_options
  end

  def extend_with_helpers(scope)
    scope.extend(@class.helpers) if @class.respond_to?(:helpers)
  end

  def block_layouts_for(scope)
    scope.instance_variable_set(:@layout, NO_LAYOUT_KEYWORD)
  end

end