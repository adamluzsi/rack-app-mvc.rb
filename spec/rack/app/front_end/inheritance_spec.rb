require 'spec_helper'
require 'rack/app/test'
require File.join(File.dirname(__FILE__),'inheritance_spec','rack_app_inheritance_child')

describe Rack::App do
  include Rack::App::Test
  describe '.inherited' do

    rack_app RackAppInheritanceChild

    it { expect(get(:url => '/say').body).to eq '<body><p>Hello world!</p></body>' }

    it 'should fire the registered block on multiple inheritance' do
      child1 = Class.new(RackAppInheritanceChild)
      child2 = Class.new(child1)

      expect(child2.layout).to eq RackAppInheritanceParent.layout
    end

    it 'inherit the helpers from the parent class' do
      expect(get(:url => '/helper').body).to eq '<body>Hello world!</body>'
    end

  end
end