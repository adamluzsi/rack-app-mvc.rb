module Rack::App::FrontEnd::InstanceMethods

  def render(template_path)
    full_path = Rack::App::Utils.expand_path(template_path)
    template = Rack::App::FrontEnd::Template.new(full_path, self.class)
    return template.render(self)
  end

end