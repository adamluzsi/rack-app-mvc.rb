module Rack::App::FrontEnd::InstanceMethods

  def render(template_path)

    options = {}
    options[:layout]= self.class.layout if self.class.respond_to?(:layout)
    full_path = Rack::App::Utils.expand_path(template_path)
    template = Rack::App::FrontEnd::Template.new(full_path, options)

    return template.render(self)

  end

end