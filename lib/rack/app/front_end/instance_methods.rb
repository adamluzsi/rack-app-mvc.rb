module Rack::App::FrontEnd::InstanceMethods

  def render(template_path, *args, &block)
    full_path = Rack::App::Utils.expand_path(template_path)
    template = Rack::App::FrontEnd::Template.new(full_path, __runtime_properties__[:layout], self.class)
    return template.render(self, *args, &block)
  end

  def __runtime_properties__
    @__runtime_properties__ ||= {}
  end

end