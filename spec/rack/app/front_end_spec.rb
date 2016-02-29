require 'spec_helper'

describe Rack::App::FrontEnd do

  include Rack::App::Test
  rack_app do
    extend Rack::App::FrontEnd
  end

  let(:instance){ rack_app }

  it 'has a version number' do
    expect(Rack::App::FrontEnd::VERSION).not_to be nil
  end

  describe '.layout' do
    subject{ instance.layout }

    context 'when it is not pre defined' do
      it { is_expected.to be nil}
    end

    context 'when it is defined with relative' do
      before{ instance.layout 'layout.html.erb' }

      it { is_expected.to be_a String}

      it { is_expected.to eq Rack::App::Utils.pwd('spec','rack','app','front_end_spec','layout.html.erb') }
    end

    context 'when it is defined with relative' do
      before{ instance.layout './../../fixtures/layout.html.erb' }

      it { is_expected.to be_a String}

      it { is_expected.to eq Rack::App::Utils.pwd('spec','fixtures','layout.html.erb') }
    end

    context 'when it is defined with project root absolute path' do
      before{ instance.layout '/spec/fixtures/layout.html.erb' }

      it { is_expected.to be_a String}

      it { is_expected.to eq Rack::App::Utils.pwd('spec','fixtures','layout.html.erb') }
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

      it { expect(get(:url => '/template').body.join.gsub("\n",'')).to eq "<body><p>HELLO WORLD!</p><p>Hello world!</p></body>" }

    end

  end

  describe '.precache_templates' do

    rack_app do
      extend Rack::App::FrontEnd

      precache_templates Rack::App::Utils.pwd('spec','fixtures','hello.html')

      get '/say' do
        render(Rack::App::Utils.pwd('spec','fixtures','hello.html'))
      end

    end

    it 'should cache already the template and not create the new one' do

      rack_app # create class

      expect(Tilt).to_not receive(:new)

      expect(get(:url => '/say').body.join).to eq '<p>Hello world!</p>'

    end

  end

  describe '.helpers' do

    rack_app do

      extend Rack::App::FrontEnd

      helpers do

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

    end

    it { expect(get(:url => '/in_app_space').body.join).to eq 'false' }

    it { expect(get(:url => '/in_template_space').body.join).to eq '<p>Hello world!</p>' }

  end

end
