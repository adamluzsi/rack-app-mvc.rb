# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack/app/front_end/version'

Gem::Specification.new do |spec|

  spec.name          = "rack-app-front_end"
  spec.version       = Rack::App::FrontEnd::VERSION
  spec.authors       = ["Adam Luzsi"]
  spec.email         = ["adamluzsi@gmail.com"]

  spec.summary       = %q{Rack::App FrontEnd framework to create beautiful website with style}
  spec.description   = %q{Rack::App FrontEnd framework to create beautiful website with style}
  spec.homepage      = 'http://www.rack-app.com/'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"

  spec.add_development_dependency "maruku"

  spec.add_dependency 'rack-app'
  spec.add_dependency 'tilt'
  spec.add_dependency 'pwd'

end
