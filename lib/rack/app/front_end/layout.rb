class Rack::App::FrontEnd::Layout < Rack::App::FrontEnd::Template

  def render(content)
    return render_result(content)
  end

  protected

  def render_result(content)
    if it_is_a_template? and layout_file_is_exists?
      render_with_tilt_templates([], -> { content })
    else
      return content
    end
  end

  def layout_file_is_exists?
    File.exists?(@file_path)
  end

end