require 'spec_helper'
require 'rack/app/test'

describe Rack::App::FrontEnd::FolderMounter do

  let(:instance) { described_class.new(rack_app) }

  include Rack::App::Test
  rack_app do

    extend Rack::App::FrontEnd

    def initialize
      @say = 'hello world'
    end

  end

  describe '#mount' do
    let(:folder_path) { Rack::App::Utils.pwd('spec', 'fixtures') }
    subject { instance.mount(folder_path) }

    context 'when static template file requested' do

      it 'should send as raw string object for rack body' do
        subject
        expect(get(:url => '/raw').body.join).to be_a String
        expect(get(:url => '/raw').body.join).to eq "hello world!\nhow you doing?"
      end

    end

    it 'should parse and fetch the raw text' do
      subject
      expect(get(:url => '/index').body).to eq ["<p>hello world</p>"]
    end

  end

end