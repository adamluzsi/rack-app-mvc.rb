module Rack::App::FrontEnd::SingletonMethods

  def mount_folder(folder_path)
    Rack::App::FrontEnd::FolderMounter.new(self).mount(Rack::App::Utils.expand_path(folder_path))
  end

  alias mount_templates_from mount_folder

  def layout(layout_path=nil)
    @layout = Rack::App::Utils.expand_path(layout_path) unless layout_path.nil?
    @layout
  end

  def helpers(&block)

    @helpers ||= lambda {
      helpers_module = Module.new
      helpers_module.__send__(:include, Rack::App::FrontEnd::Helpers)
      helpers_module.__send__(:extend, Rack::App::FrontEnd::SyntaxSugar::DSL)
    }.call

    @helpers.class_eval(&block) unless block.nil?

    return @helpers
  end

end