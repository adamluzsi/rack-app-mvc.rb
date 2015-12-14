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

    it 'should stream non templates' do
      subject
      expect(get(:url => '/raw.txt').body).to be_a Rack::App::File::Streamer
    end

    it 'should parse and fetch the raw text' do
      subject
      expect(get(:url => '/index.html.erb').body).to eq ["<p>hello world</p>"]
    end

    it 'should parse even mixed templates such us markdown and erb' do
      subject
      expect(get(:url => '/index.md.erb').body).to eq ["<h1>hello world</h1>\n"]
    end

  end

end