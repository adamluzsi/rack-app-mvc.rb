require 'spec_helper'

describe Rack::App::FrontEnd::Template do

  include Rack::App::Test

  rack_app do
    extend Rack::App::FrontEnd

    get '/hello' do
      @say = 'hello world!'
      render(params['file_path'])
    end

  end

  describe '#render' do
    subject { get(:url => '/hello', :params => {'file_path' => file_path}).body.join }

    context 'when file is a html with erb' do

      let(:file_path) { Rack::App::Utils.pwd('spec', 'fixtures', 'index.html.erb') }

      it { is_expected.to eq '<p>hello world!</p>' }

      context 'when template given' do

        before { rack_app.layout(Rack::App::Utils.pwd('spec', 'fixtures', 'layout.html.erb')) }

        it { is_expected.to eq '<body><p>hello world!</p></body>' }

        context 'and the template includes dynamic content or method call' do
          before { rack_app.layout(Rack::App::Utils.pwd('spec', 'fixtures', 'dynamic_layout.html.erb')) }

          it { is_expected.to eq '<body>HELLO WORLD!|<p>hello world!</p></body>' }
        end
      end

    end

  end

end