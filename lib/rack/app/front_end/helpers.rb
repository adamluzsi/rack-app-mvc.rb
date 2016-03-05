module Rack::App::FrontEnd::Helpers

  require 'rack/app/front_end/helpers/html_dsl'
  require 'rack/app/front_end/helpers/boilerplate'
  require 'rack/app/front_end/helpers/rendering'

  include Rack::App::FrontEnd::Helpers::Rendering

end