require 'pwd'
class Rack::App::FrontEnd::FolderMounter

  def initialize(app_class)
    @app_class = app_class
  end

  def mount(folder_path)
    source_folder_path = get_source_path(folder_path)
    template_paths_for(source_folder_path).each do |template_path|

      request_path = request_path_by(source_folder_path, template_path)
      template = Rack::App::FrontEnd::Template.new(template_path, fallback_handler: Rack::App::File::Streamer)
      create_endpoint_for(request_path, template)

    end
  end

  def get_source_path(folder_path)
    if folder_path.to_s[0] == File::Separator
      PWD.join(folder_path)
    else
      File.join(File.dirname(caller[1].split(':')[0]),folder_path)
    end
  end

  protected

  def template_paths_for(source_folder_path)
    Dir.glob(File.join(source_folder_path, '**', '*'))
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