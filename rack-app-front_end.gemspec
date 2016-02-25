# coding: utf-8

Gem::Specification.new do |spec|

  spec.name          = "rack-app-front_end"
  spec.version       = File.read(File.join(File.dirname(__FILE__), 'VERSION')).strip
  spec.authors       = ["Adam Luzsi"]
  spec.email         = ["adamluzsi@gmail.com"]

  spec.summary       = %q{Rack::App FrontEnd framework to create beautiful website with style}
  spec.description   = %q{Rack::App FrontEnd framework to create beautiful website with style}
  spec.homepage      = 'http://www.rack-app.com/'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 1.9.3'

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  spec.add_dependency 'rack-app','>= 0.24.0'
  spec.add_dependency 'tilt'

end
