module Rack::App::FrontEnd::Helpers

  def render(template_path, variables={}, options={}, &block)
    full_path = Rack::App::Utils.expand_path(template_path)
    template = Rack::App::FrontEnd::Template.new(full_path,options)
    return template.render(self, variables, &block)
  end

end