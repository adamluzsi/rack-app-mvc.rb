require 'spec_helper'

InstanceMethodsSpec = Class.new
describe Rack::App::FrontEnd::InstanceMethods do

  let(:instance) do
    o = InstanceMethodsSpec.new
    o.extend(described_class)
    o
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
      before { allow(InstanceMethodsSpec).to receive(:layout).and_return(Rack::App::Utils.pwd('spec', 'fixtures', 'layout.html.erb')) }

      let(:path) { Rack::App::Utils.pwd('spec', 'fixtures', 'hello.html') }

      it { is_expected.to eq '<body><p>Hello world!</p></body>' }
    end

  end

end