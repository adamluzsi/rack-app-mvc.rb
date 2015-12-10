require 'spec_helper'

describe Rack::App::FrontEnd::Layout do
  let(:instance) { described_class.new(file_path) }

  describe '#render' do
    subject { instance.render('hello world!') }

    context 'when file given with from root path' do
      let(:file_path) { PWD.join('spec','fixtures','layout.html.erb') }

      it { is_expected.to eq '<body>hello world!</body>'}
    end

    context 'when file given with relative path' do
      let(:file_path) { PWD.join('spec','fixtures','layout.html.erb') }

      it { is_expected.to eq '<body>hello world!</body>'}
    end

  end

end