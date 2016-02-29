require 'tilt'
class Rack::App::FrontEnd::Template
  NO_LAYOUT_KEYWORD = :none

  require 'rack/app/front_end/template/default_layout'

  def self.cache
    @cache ||= Tilt::Cache.new
  end

  def render(scope, *args, &block)
    return render_result(scope, *args, &block)
  end

  protected

  def initialize(template_path, klass)
    @file_path = template_path
    @class = klass
  end

  def render_result(scope, *args, &block)
    return Rack::App::File::Streamer.new(@file_path) unless it_is_a_template?
    extend_with_helpers(scope)
    layout(scope).render(scope, *args) { template.render(scope, *args, &block) }
  end

  def it_is_a_template?
    not Tilt.templates_for(@file_path).empty?
  end

  def template
    get_template(@file_path)
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
    self.class.cache.fetch(file_path) { Tilt.new(file_path) }
  end

  def extend_with_helpers(scope)
    scope.extend(@class.helpers) if @class.respond_to?(:helpers)
  end

  def block_layouts_for(scope)
    scope.instance_variable_set(:@layout, NO_LAYOUT_KEYWORD)
  end

end