require 'spec_helper'

describe Rack::App::FrontEnd::EndpointMethods do

  let(:instance) do
    o = Object.new
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
      let(:path) { Rack::App::Utils.pwd('spec','fixtures','hello.html') }

      it { is_expected.to eq '<p>Hello world!</p>' }
    end

  end

end