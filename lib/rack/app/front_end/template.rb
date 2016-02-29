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

  def initialize(file_path, klass)
    @file_path = file_path
    @class = klass
  end

  def render_result(scope, *args, &block)
    return Rack::App::File::Streamer.new(@file_path) unless it_is_a_template?
    scope.extend(@class.helpers) if @class.respond_to?(:helpers)
    layout.render(scope, *args) { template.render(scope, *args, &block) }
  end

  def it_is_a_template?
    not Tilt.templates_for(@file_path).empty?
  end

  def template
    get_template(@file_path)
  end

  def layout
    return DefaultLayout if @class.respond_to?(:layout) and @class.layout.nil?
    return DefaultLayout if @file_path =~ /^#{Regexp.escape(Rack::App::Utils.namespace_folder(@class.layout))}/
    get_template(@class.layout)
  end

  def get_template(file_path)
    self.class.cache.fetch(file_path) { Tilt.new(file_path) }
  end

end