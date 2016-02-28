module Rack::App::FrontEnd::Template::DefaultLayout
  extend self

  def render(*args, &block)
    block.call
  end

end