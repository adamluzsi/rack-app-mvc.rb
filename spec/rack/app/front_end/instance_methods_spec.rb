require 'spec_helper'

InstanceMethodsSpec = Class.new
describe Rack::App::FrontEnd::InstanceMethods do

  include Rack::App::Test

  rack_app do
    extend Rack::App::FrontEnd
  end

  let(:instance) do
    rack_app.new
  end

  describe '#render' do
    subject { instance.render(path) }

    context 'when app class relative path given' do
      let(:path) { 'hello.html' }

      it { is_expected.to eq '<p>hello world!</p>' }
    end

    context 'when app class relative path given' do
      let(:path) { Rack::App::Utils.pwd('spec', 'fixtures', 'hello.html') }

      it { is_expected.to eq '<p>Hello world!</p>' }
    end

    context 'when app class relative path given' do
      let(:path) { '/spec/fixtures/hello.html' }

      it { is_expected.to eq '<p>Hello world!</p>' }
    end

    context 'when layout defined' do
      before{ rack_app.layout(Rack::App::Utils.pwd('spec', 'fixtures', 'layout.html.erb')) }

      let(:path) { Rack::App::Utils.pwd('spec', 'fixtures', 'hello.html') }

      it { is_expected.to eq '<body><p>Hello world!</p></body>' }
    end

  end

end