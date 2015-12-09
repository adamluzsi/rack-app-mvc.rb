require 'spec_helper'

describe Rack::App::FrontEnd do

  it 'has a version number' do
    expect(Rack::App::FrontEnd::VERSION).not_to be nil
  end

end
