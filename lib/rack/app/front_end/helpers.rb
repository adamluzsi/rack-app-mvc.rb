module Rack::App::FrontEnd::Helpers

  require 'rack/app/front_end/helpers/html_dsl'
  require 'rack/app/front_end/helpers/table'
  require 'rack/app/front_end/helpers/rendering'

  include Rack::App::FrontEnd::Helpers::Rendering
  include Rack::App::FrontEnd::Helpers::Table

  def path_to(*args)
    @request.env[::Rack::App::Constants::ENV::HANDLER].path_to(*args)
  end

end