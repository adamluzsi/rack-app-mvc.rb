class Rack::App::FrontEnd::FolderMounter

  LAST_MODIFIED_HEADER = "Last-Modified"

  def initialize(app_class)
    @app_class = app_class
  end

  def mount(absolute_folder_path)
    template_paths_for(absolute_folder_path).each do |template_path|

      request_path = request_path_by(absolute_folder_path, template_path)
      template = Rack::App::FrontEnd::Template.new(template_path, :fallback_handler => Rack::App::File::Streamer)

      create_endpoint_for(request_path, template_path)

    end
  end

  protected

  def template_paths_for(source_folder_path)
    Dir.glob(File.join(source_folder_path, '**', '*')).select { |p| not File.directory?(p) }
  end

  def create_endpoint_for(request_path, template_path)
    @app_class.class_eval do

      get(request_path) do
        result = render(template_path)

        if result.is_a?(::Rack::App::File::Streamer)
          result
        else
          self.class.layout.render(result)
        end

      end

    end
  end

  def request_path_by(source_folder_path, template_path)
    Rack::Utils.clean_path_info(template_path.sub(source_folder_path, '').split(File::Separator).join('/'))
  end

end