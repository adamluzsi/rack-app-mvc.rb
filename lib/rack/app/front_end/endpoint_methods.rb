module Rack::App::FrontEnd::EndpointMethods

  def render(template_path, variables={}, options={}, &block)
    options = {:layout_path => self.class.layout}.merge(options)

    scope = Rack::App::FrontEnd::Template::Scope.new
    scope.extend(self.class.helpers)
    scope.inherit_instance_variables!(self)

    full_path = Rack::App::Utils.expand_path(template_path)
    template = Rack::App::FrontEnd::Template.new(full_path, options)

    return template.render(scope, variables, &block)
  end

end