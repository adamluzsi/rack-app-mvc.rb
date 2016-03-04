require 'tilt'
class Rack::App::FrontEnd::Template

  require 'rack/app/front_end/template/scope'
  require 'rack/app/front_end/template/default_layout'
  require 'rack/app/front_end/template/default_template'

  def self.cache
    @cache ||= Tilt::Cache.new
  end

  def self.template?(file_path)
    not Tilt.templates_for(file_path).empty?
  end

  def render(scope, variables={}, &block)
    layout.render(scope, variables) { template.render(scope, variables, &block) }
  end


  protected

  DEFAULT_TEMPLATE_OPTIONS = {:default_encoding => "utf-8"}

  def initialize(template_path, options={})
    @file_path = template_path
    @layout_path = options.delete(:layout_path)
    @template_options = DEFAULT_TEMPLATE_OPTIONS.merge(options)
  end

  def template
    if self.class.template?(@file_path)
      get_template(@file_path)
    else
      DefaultTemplate.new(@file_path)
    end
  end

  def layout
    return DefaultLayout if use_default_layout?

    get_template(@layout_path)
  end

  def use_default_layout?
    @layout_path.nil? or
        not File.exist?(@layout_path) or
        (@file_path =~ /^#{Regexp.escape(Rack::App::Utils.namespace_folder(@layout_path))}/)
  end

  def get_template(file_path)
    self.class.cache.fetch(file_path) { Tilt.new(file_path, @template_options) }
  end

end