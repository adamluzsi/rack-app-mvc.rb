module Rack::App::FrontEnd::SingletonMethods

  def mount_folder(folder_path)
    Rack::App::FrontEnd::FolderMounter.new(self).mount(Rack::App::FrontEnd::Utils.get_full_path(folder_path))
  end

  alias mount_templates_from mount_folder

  def layout(layout_path=nil)
    @layout = Rack::App::FrontEnd::Utils.get_full_path(layout_path) unless layout_path.nil?
    @layout
  end

end