require 'rack/app'
module Rack::App::FrontEnd

  require 'tilt'
  require 'tilt/plain'

  require 'rack/app/front_end/version'
  require 'rack/app/front_end/utils'
  require 'rack/app/front_end/template'
  require 'rack/app/front_end/layout'
  require 'rack/app/front_end/view'
  require 'rack/app/front_end/folder_mounter'
  require 'rack/app/front_end/endpoint_methods'

  def self.extended(klass)
    klass.__send__(:include, ::Rack::App::FrontEnd::EndpointMethods)
  end

  def mount_folder(folder_path)
    Rack::App::FrontEnd::FolderMounter.new(self).mount(Rack::App::FrontEnd::Utils.get_full_path(folder_path))
  end

  alias mount_templates_from mount_folder

  def layout(layout_path=nil)
    @layout = Rack::App::FrontEnd::Layout.new(Rack::App::FrontEnd::Utils.get_full_path(layout_path)) unless layout_path.nil?
    @layout || Rack::App::FrontEnd::Layout.new(nil)
  end

end