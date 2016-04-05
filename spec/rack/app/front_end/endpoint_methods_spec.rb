require 'spec_helper'

InstanceMethodsSpec = Class.new
describe Rack::App::FrontEnd::EndpointMethods do

  include Rack::App::Test

  rack_app do
    apply_extensions :front_end
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

      rack_app do

        apply_extensions :front_end

        layout(Rack::App::Utils.pwd('spec', 'fixtures', 'layout.html.erb'))

        get '/' do
          render Rack::App::Utils.pwd('spec', 'fixtures', 'hello.html')
        end

      end

      it { expect(get('/').body).to eq '<body><p>Hello world!</p></body>' }

    end

  end

end