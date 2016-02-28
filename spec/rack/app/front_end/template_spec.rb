require 'spec_helper'

describe Rack::App::FrontEnd::Template do
  let(:options) { {} }
  let(:instance) { described_class.new(file_path, options) }

  let(:object) { Object.new.tap { |o| o.instance_eval { @say = 'hello world!' } } }

  describe '#render' do
    subject { instance.render(object) }

    context 'when file is a html with erb' do
      let(:file_path) { Rack::App::Utils.pwd('spec', 'fixtures', 'index.html.erb') }

      it { is_expected.to eq '<p>hello world!</p>' }

      context 'when template given' do
        before{ options[:layout]= Rack::App::Utils.pwd('spec','fixtures','layout.html.erb') }

        it { is_expected.to eq '<body><p>hello world!</p></body>' }

        context 'and the template includes dynamic content or method call' do
          before{ options[:layout]= Rack::App::Utils.pwd('spec','fixtures','dynamic_layout.html.erb') }
          before{ object.instance_eval { @layout_text = 'sup' }}

          it { is_expected.to eq '<body>sup|<p>hello world!</p></body>' }
        end
      end

    end

  end

end