require 'spec_helper'

describe Rack::App::FrontEnd::Template do
  let(:instance) { described_class.new(file_path) }

  let(:object) { Object.new.tap { |o| o.instance_eval { @say = 'hello world!' } } }

  describe '#render' do
    subject { instance.render(object) }

    context 'when file is a html with erb' do
      let(:file_path) { Rack::App::Utils.pwd('spec', 'fixtures', 'index.html.erb') }

      it { is_expected.to eq '<p>hello world!</p>'}
    end

    context 'when file is a markdown with erb' do
      let(:file_path) { Rack::App::Utils.pwd('spec', 'fixtures', 'index.md.erb') }

      it { is_expected.to eq "<h1>hello world!</h1>\n"}
    end

  end

end