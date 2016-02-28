require 'tilt'
class Rack::App::FrontEnd::Template

  require 'rack/app/front_end/template/default_layout'

  def self.cache
    @cache ||= Tilt::Cache.new
  end

  def render(*args, &block)
    return render_result(*args, &block)
  end

  protected

  def initialize(file_path, options={})
    @file_path = file_path
    @options = options
  end

  def render_result(*args, &block)
    return Rack::App::File::Streamer.new(@file_path) unless it_is_a_template?

    layout.render(*args) { template.render(*args, &block) }
  end

  def it_is_a_template?
    not Tilt.templates_for(@file_path).empty?
  end

  def template
    get_template(@file_path)
  end

  def layout
    @options[:layout] ? get_template(@options[:layout]) : DefaultLayout
  end

  def get_template(file_path)
    self.class.cache.fetch(file_path) { Tilt.new(file_path) }
  end

end