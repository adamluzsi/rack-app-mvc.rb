require 'rack/app'
module Rack::App::FrontEnd

  require 'tilt'
  require 'tilt/plain'

  require 'rack/app/front_end/utils'
  require 'rack/app/front_end/version'
  require 'rack/app/front_end/helpers'
  require 'rack/app/front_end/template'
  require 'rack/app/front_end/syntax_sugar'
  require 'rack/app/front_end/folder_mounter'
  require 'rack/app/front_end/endpoint_methods'
  require 'rack/app/front_end/singleton_methods'

  class << self

    [:extended, :included].each do |method|
      define_method(method) do |klass|

        klass.__send__(:include, self::EndpointMethods)
        klass.__send__(:extend, self::SingletonMethods)

        klass.on_inheritance do |parent, child|

          child.layout(parent.layout)

          child.helpers do
            include(parent.helpers)
          end

        end

      end
    end

  end

  if Rack::App::VERSION >= '3.0.0'

    Rack::App::Extension.register :front_end do

      include Rack::App::FrontEnd::EndpointMethods
      extend Rack::App::FrontEnd::SingletonMethods

      on_inheritance do |parent, child|

        child.layout(parent.layout)

        child.helpers do
          include(parent.helpers)
        end

      end

    end

  end

end