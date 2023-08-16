require 'spec_helper'
describe Rack::App::FrontEnd do

  include Rack::App::Test
  rack_app do
    apply_extensions :front_end
  end

  let(:instance) { rack_app }

  it 'has a version number' do
    expect(Rack::App::FrontEnd::VERSION).not_to be nil
  end

  describe '.layout' do
    subject { rack_app.layout }

    context 'when it is not pre defined' do
      it { is_expected.to be nil }
    end

    context 'when it is defined with relative' do
      before { rack_app.layout 'layout.html.erb' }

      it { is_expected.to be_a String }

      it { is_expected.to eq Rack::App::Utils.pwd('spec', 'rack', 'app', 'front_end_spec', 'layout.html.erb') }
    end

    context 'when it is defined with relative' do
      before { rack_app.layout './../../fixtures/layout.html.erb' }

      it { is_expected.to be_a String }

      it { is_expected.to eq Rack::App::Utils.pwd('spec', 'fixtures', 'layout.html.erb') }
    end

    context 'when it is defined with project root absolute path' do
      before { rack_app.layout '/spec/fixtures/layout.html.erb' }

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

      it { expect(get(:url => '/template').body.gsub("\n", '')).to eq "<body><p>HELLO WORLD!</p><p>Hello world!</p></body>" }

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
        include helper :table

        def hello_world!
          'Hello world!'
        end
        
        def get_instance_var
          @var_name
        end

      end
      
      def initialize
        @var_name = 42
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

      get '/table' do
        render 'table.html.erb', array_of_hash: [{:hello => 'world'}]
      end

      get '/ivar' do 
        render 'ivar.html.erb'
      end
      
    end

    it { expect(get(:url => '/in_app_space').body).to eq 'false' }

    it { expect(get(:url => '/in_template_space').body).to eq '<p>Hello world!</p>' }

    it { expect(get(:url => '/html_dsl_extension').body).to eq '<label>Hello world!</label>' }

    it { expect(get(:url => '/table').body).to eq "<table><tr><td>hello</td></tr><tr><td>world</td></tr></table>" }
    
    it { expect(get(:url => '/ivar').body).to eq "42 - 42" }

  end

end
