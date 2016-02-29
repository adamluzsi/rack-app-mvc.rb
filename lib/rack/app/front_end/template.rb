require 'tilt'
class Rack::App::FrontEnd::Template

  require 'rack/app/front_end/template/default_layout'

  def self.cache
    @cache ||= Tilt::Cache.new
  end

  def render(scope, *args, &block)
    return render_result(scope, *args, &block)
  end

  protected

  def initialize(template_path, layout, klass)
    @file_path = template_path
    @layout = layout
    @class = klass
  end

  def render_result(scope, *args, &block)
    return Rack::App::File::Streamer.new(@file_path) unless it_is_a_template?
    extend_with_helpers(scope)
    block_layouts_for(scope)
    layout.render(scope, *args) { template.render(scope, *args, &block) }
  end

  def it_is_a_template?
    not Tilt.templates_for(@file_path).empty?
  end

  def template
    get_template(@file_path)
  end

  def layout

    return DefaultLayout if @layout == :none
    return DefaultLayout if @class.respond_to?(:layout) and @class.layout.nil?
    return DefaultLayout if @file_path =~ /^#{Regexp.escape(Rack::App::Utils.namespace_folder(@class.layout))}/

    get_template(@class.layout)
  end

  def get_template(file_path)
    self.class.cache.fetch(file_path) { Tilt.new(file_path) }
  end

  def extend_with_helpers(scope)
    scope.extend(@class.helpers) if @class.respond_to?(:helpers)
  end

  def block_layouts_for(scope)
    scope.instance_variable_set(:@layout, :none)
  end

end