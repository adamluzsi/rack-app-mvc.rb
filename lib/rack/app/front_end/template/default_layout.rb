module Rack::App::FrontEnd::Template::DefaultLayout
  extend self

  def render(&block)
    block.call
  end

end