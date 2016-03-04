require 'spec_helper'
require 'rack/app/test'

class RackAppInheritanceParent < Rack::App

  extend Rack::App::FrontEnd

  helpers do

    def hello_world
      'Hello world!'
    end

  end

  layout Rack::App::Utils.pwd('spec','fixtures','layout.html.erb')

end

class RackAppInheritanceChild < RackAppInheritanceParent

  get '/say' do
    render('say.html')
  end

  get '/helper' do
    render 'hello.html.erb'
  end

end

describe Rack::App do
  include Rack::App::Test
  describe '.inherited' do

    rack_app RackAppInheritanceChild

    it { expect(get(:url => '/say').body.join).to eq '<body><p>Hello world!</p></body>' }

    it 'should fire the registered block on multiple inheritance' do
      child1 = Class.new(RackAppInheritanceChild)
      child2 = Class.new(child1)

      expect(child2.layout).to eq RackAppInheritanceParent.layout
    end

    it 'inherit the helpers from the parent class' do
      expect(get(:url => '/helper').body.join).to eq '<body>Hello world!</body>'
    end

  end
end