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

  describe 'layout' do
    subject{ instance.layout }

    context 'when it is not pre defined' do
      it { is_expected.to be_a Rack::App::FrontEnd::Layout}

      it 'should be able to render layout using the predefined layout file' do
        expect(subject.render('hello')).to eq "hello"
      end

    end

    context 'when it is defined to what' do
      before{ instance.layout '../../fixtures/layout.html.erb' }

      it { is_expected.to be_a Rack::App::FrontEnd::Layout}

      it 'should be able to render layout using the predefined layout file' do
        expect(subject.render('hello')).to eq "<body>hello</body>"
      end

    end

  end

end
