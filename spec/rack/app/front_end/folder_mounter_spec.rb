require 'spec_helper'
require 'rack/app/test'

describe Rack::App::FrontEnd::FolderMounter do

  let(:instance) { described_class.new(rack_app) }

  include Rack::App::Test
  rack_app do

    def initialize
      @say = 'hello world'
    end

  end

  describe '#mount' do
    let(:folder_path) { '/spec/fixtures' }
    subject { instance.mount(folder_path) }

    it 'should stream non templates' do
      subject
      response = get '/raw.txt'
      expect(response.body).to be_a Rack::App::File::Streamer
    end

    it 'should parse and fetch the raw text' do
      subject
      response = get '/index.html.erb'
      expect(response.body).to eq ["<p>hello world</p>"]
    end

    it 'should parse even mixed templates such us markdown and erb' do
      subject
      response = get '/index.md.erb'
      expect(response.body).to eq ["<h1>hello world</h1>\n"]
    end

    context 'when mount path is not meant from project root but relative to current folder' do
      let(:folder_path){ 'view_spec' }

      it 'should parse and fetch the raw text' do
        subject
        response = get '/index.html.erb'
        expect(response.body).to eq ["hello world!"]
      end

    end

  end

end