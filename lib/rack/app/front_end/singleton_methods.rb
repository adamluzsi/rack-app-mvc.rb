module Rack::App::FrontEnd::SingletonMethods

  def mount_folder(folder_path)
    Rack::App::FrontEnd::FolderMounter.new(self).mount(Rack::App::Utils.expand_path(folder_path))
  end

  alias mount_templates_from mount_folder

  def layout(layout_path=nil)
    @layout = Rack::App::Utils.expand_path(layout_path) unless layout_path.nil?
    @layout
  end

  def template_options(hash=nil)
    @template_options ||= {:default_encoding => "utf-8"}
    @template_options.merge!(hash) if hash.is_a?(Hash)
    @template_options
  end

  def helpers(&block)
    @helpers ||= Module.new
    @helpers.class_eval(&block) unless block.nil?
    @helpers
  end

end