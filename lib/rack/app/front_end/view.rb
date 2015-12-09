class Rack::App::FrontEnd::View

  def render(view_file_basename)
    file_path = File.join(class_current_folder, view_file_basename)

    Rack::App::FrontEnd::Template.new(file_path).render(self)
  end

  def class_current_folder
    method(:call).source_location.first.sub(/.rb$/,'')
  end

end