class RackAppInheritanceParent < Rack::App

  apply_extensions :front_end

  helpers do

    def hello_world
      'Hello world!'
    end

  end

  layout Rack::App::Utils.pwd('spec','fixtures','layout.html.erb')

end