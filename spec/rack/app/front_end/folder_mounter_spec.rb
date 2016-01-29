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
      it 'should send stream object for rack body' do
        subject
        expect(get(:url => '/raw.txt').body).to be_a Rack::App::File::Streamer
      end

      it 'should set the headers' do
        subject
        expect(get(:url => '/raw.txt').headers).to eq "Last-Modified" => "Wed, 09 Dec 2015 23:44:53 GMT"
      end

      it 'should update content length' do
        subject
        expect(get(:url => '/raw.txt').length).to eq 27
      end
    end

    it 'should parse and fetch the raw text' do
      subject
      expect(get(:url => '/index.html.erb').body).to eq ["<p>hello world</p>"]
    end

    it 'should parse even mixed templates such us markdown and erb' do
      subject
      expect(get(:url => '/index.md.erb').body).to eq ["<h1 id=\"hello-world\">hello world</h1>\n"]
    end

  end

end