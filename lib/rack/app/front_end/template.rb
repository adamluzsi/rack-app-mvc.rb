require 'tilt'
class Rack::App::FrontEnd::Template

  require 'rack/app/front_end/template/default_layout'

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

    layout.render { Tilt.new(@file_path).render(*args, &block) }
  end

  def it_is_a_template?
    not Tilt.templates_for(@file_path).empty?
  end

  def layout
    @options[:layout] ? Tilt.new(@options[:layout]) : DefaultLayout
  end

end