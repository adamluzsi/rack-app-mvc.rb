require 'pwd'
class Rack::App::FrontEnd::FolderMounter

  def initialize(app_class)
    @app_class = app_class
  end

  def mount(path_from_project_root)
    source_folder_path = PWD.join(path_from_project_root)
    template_paths_for(path_from_project_root).each do |template_path|

      request_path = request_path_by(source_folder_path, template_path)
      template = Rack::App::FrontEnd::Template.new(template_path, fallback_handler: Rack::App::File::Streamer)
      create_endpoint_for(request_path, template)

    end
  end

  protected

  def template_paths_for(path_from_project_root)
    Dir.glob(File.join(PWD.join(path_from_project_root), '**', '*'))
        .select { |p| not File.directory?(p) }
  end

  def create_endpoint_for(request_path, template)
    @app_class.class_eval do

      get(request_path) do
        result = template.render(self)
        if result.respond_to?(:each)
          response.body = result
        else
          response.write(result)
        end
        response.finish
      end

    end
  end

  def request_path_by(source_folder_path, template_path)
    Rack::Utils.clean_path_info template_path
                                    .sub(source_folder_path, '')
                                    .split(File::Separator).join('/')

  end

end