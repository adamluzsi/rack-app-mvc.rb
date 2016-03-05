require 'spec_helper'

describe Rack::App::FrontEnd do

  include Rack::App::Test
  rack_app do
    extend Rack::App::FrontEnd
  end

  let(:instance) { rack_app }

  it 'has a version number' do
    expect(Rack::App::FrontEnd::VERSION).not_to be nil
  end

  describe '.layout' do
    subject { instance.layout }

    context 'when it is not pre defined' do
      it { is_expected.to be nil }
    end

    context 'when it is defined with relative' do
      before { instance.layout 'layout.html.erb' }

      it { is_expected.to be_a String }

      it { is_expected.to eq Rack::App::Utils.pwd('spec', 'rack', 'app', 'front_end_spec', 'layout.html.erb') }
    end

    context 'when it is defined with relative' do
      before { instance.layout './../../fixtures/layout.html.erb' }

      it { is_expected.to be_a String }

      it { is_expected.to eq Rack::App::Utils.pwd('spec', 'fixtures', 'layout.html.erb') }
    end

    context 'when it is defined with project root absolute path' do
      before { instance.layout '/spec/fixtures/layout.html.erb' }

      it { is_expected.to be_a String }

      it { is_expected.to eq Rack::App::Utils.pwd('spec', 'fixtures', 'layout.html.erb') }
    end

    context 'when layout reference includes another template rendering' do

      rack_app do

        extend Rack::App::FrontEnd

        layout 'layout.html.erb'

        get '/template' do
          @text = 'Hello world!'
          render 'index.html.erb'
        end

      end

      it { expect(get(:url => '/template').body.join.gsub("\n", '')).to eq "<body><p>HELLO WORLD!</p><p>Hello world!</p></body>" }

    end

  end

  describe '#render' do

    context 'when template options is given' do

      rack_app do

        extend Rack::App::FrontEnd

        get '/bumm' do
          render 'utf8.html', {}, {:default_encoding => 'ASCII'}
        end

      end

      it { expect { get(:url => '/bumm') }.to raise_error Encoding::InvalidByteSequenceError, /not valid US-ASCII/ }

    end

    context 'when template options is left to be default' do

      rack_app do

        extend Rack::App::FrontEnd

        get '/bumm' do
          render 'utf8.html'
        end

      end

      it { expect { get(:url => '/bumm') }.to_not raise_error }

    end

  end

  describe '.helpers' do

    rack_app do

      extend Rack::App::FrontEnd

      helpers do

        include helper :html_dsl
        include helper :boilerplate

        def hello_world!
          'Hello world!'
        end

      end

      get '/in_app_space' do
        methods.include?(:hello_world!)
      end

      get '/in_template_space' do
        render 'hello.html.erb'
      end

      get '/html_dsl_extension' do
        render 'html_dsl_test.html.erb'
      end

      get '/boilerplate' do
        render 'boilerplate.html.erb', array_of_hash: [{:hello => 'world'}]
      end

    end

    it { expect(get(:url => '/in_app_space').body.join).to eq 'false' }

    it { expect(get(:url => '/in_template_space').body.join).to eq '<p>Hello world!</p>' }

    it { expect(get(:url => '/html_dsl_extension').body.join).to eq '<label>Hello world!</label>' }

    it { expect(get(:url => '/boilerplate').body.join).to eq "<table><tr><td>hello</td></tr><tr><td>world</td></tr></table>" }

  end

end
