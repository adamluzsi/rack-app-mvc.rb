require 'rack/app'
module Rack::App::FrontEnd

  require 'rack/app/front_end/version'
  require 'rack/app/front_end/template'
  require 'rack/app/front_end/view'
  require 'rack/app/front_end/folder_mounter'

  def mount_folder(path_from_project_root)
    Rack::App::FrontEnd::FolderMounter.new(self).mount(path_from_project_root)
  end

  alias mount_templates_from mount_folder

end
