require 'spec_helper'
describe '#path_to' do
  include Rack::App::Test

  rack_app do
    apply_extensions :front_end

    mount TestApp, to: '/test'

    get '/' do
      render File.join(FIXTURES_DIRECTORY, 'path_to.html.erb')
    end
  end
  subject { get('/').body }

  it { is_expected.to eq %(<a href="/test">link text</a>) }
end
