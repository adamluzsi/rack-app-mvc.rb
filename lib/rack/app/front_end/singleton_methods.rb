module Rack::App::FrontEnd::SingletonMethods

  def mount_folder(folder_path)
    Rack::App::FrontEnd::FolderMounter.new(self).mount(Rack::App::Utils.expand_path(folder_path))
  end

  alias mount_templates_from mount_folder

  def layout(layout_path=nil)
    @layout = Rack::App::Utils.expand_path(layout_path) unless layout_path.nil?
    @layout
  end

  def cache_templates(*template_paths)
    full_paths = template_paths.map { |path| Rack::App::Utils.expand_path(path) }
    full_paths.each do |full_path|
      Rack::App::FrontEnd::Template.cache.fetch(full_path) { Tilt.new(full_path) }
    end
    nil
  end

end