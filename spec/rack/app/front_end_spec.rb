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
      it { is_expected.to be nil}
    end

    context 'when it is defined to what' do
      before{ instance.layout '../../fixtures/layout.html.erb' }

      it { is_expected.to be_a String}

      it { is_expected.to eq Rack::App::Utils.pwd('spec','fixtures','layout.html.erb') }
    end

  end

end
