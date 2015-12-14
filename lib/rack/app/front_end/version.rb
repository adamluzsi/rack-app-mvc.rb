require 'rack/app/front_end'
Rack::App::FrontEnd::VERSION = File.read(File.join(File.dirname(__FILE__), '..', '..', '..', '..', 'VERSION')).strip