module Rack::App::FrontEnd::EndpointMethods

  def render(template_path)

    template_full_path = if template_path.to_s[0] == '/'
                           project_file_path = Rack::App::Utils.pwd(template_path)
                           File.exist?(project_file_path) ? project_file_path : template_path

                         else

                           app_dirname = File.join(
                               File.dirname([caller[1..1]].flatten.first.split(/\.(?:rb|ru):\d/)[0]),
                               Rack::App::FrontEnd::Utils.underscore(self.class)
                           )

                           File.join(app_dirname, template_path)

                         end

    options = {}
    options[:layout]= self.class.layout if self.class.respond_to?(:layout)
    template = Rack::App::FrontEnd::Template.new(template_full_path, options)

    return template.render(self)

  end

end