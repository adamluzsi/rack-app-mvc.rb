module Rack::App::FrontEnd::EndpointMethods

  def render(template_path)

    template_full_path = if File.exist?(template_path)
                           template_path
                         else

                           app_dirname = File.join(
                               File.dirname([caller(1..1)].flatten.first.split(/\.(?:rb|ru):\d/)[0]),
                               Rack::App::FrontEnd::Utils.underscore(self.class)
                           )

                           File.join(app_dirname, template_path)

                         end

    template = Rack::App::FrontEnd::Template.new(template_full_path)

    return template.render(self)

  end

end