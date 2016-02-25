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
        expect(get(:url => '/raw').body).to be_a Rack::App::File::Streamer
      end

      it 'should set the headers' do
        subject
        expect(get(:url => '/raw').headers["Last-Modified"]).to match /(((Mon)|(Tue)|(Wed)|(Thu)|(Fri)|(Sat)|(Sun))[,]\s\d{2}\s(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\s\d{4}\s(0\d|1\d|2[0-3])(\:)(0\d|1\d|2\d|3\d|4\d|5\d)(\:)(0\d|1\d|2\d|3\d|4\d|5\d)\s(GMT))/
      end

      it 'should update content length' do
        subject
        expect(get(:url => '/raw').length).to eq 27
      end
    end

    it 'should parse and fetch the raw text' do
      subject
      expect(get(:url => '/index').body).to eq ["<p>hello world</p>"]
    end

  end

end