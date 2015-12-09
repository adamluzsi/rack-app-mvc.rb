require 'tilt'
class Rack::App::FrontEnd::Template

  require 'rack/app/front_end/template/plain_text'

  def render(*args, &block)
    return render_result(*args, &block)
  end

  protected

  def initialize(file_path,fallback_handler: Rack::App::FrontEnd::Template::PlainText)
    @fallback_handler = fallback_handler
    @file_path = file_path
  end

  def render_result(*args, &block)
    if it_is_a_template?
      render_with_tilt_templates(args, block)
    else
      @fallback_handler.new(@file_path).render(*args, &block)
    end
  end

  def it_is_a_template?
    not Tilt.templates_for(@file_path).empty?
  end

  def render_with_tilt_templates(args, block)
    file_content = File.read(@file_path)
    Tilt.templates_for(@file_path).each do |template_engine|
      file_content = template_engine.new { file_content }.render(*args, &block)
    end
    return file_content
  end

end
