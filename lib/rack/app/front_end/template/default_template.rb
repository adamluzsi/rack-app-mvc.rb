class Rack::App::FrontEnd::Template::DefaultTemplate

  def initialize(file_path)
    @file_path = file_path
  end

  def render(*args)
    File.read(@file_path)
  end

end