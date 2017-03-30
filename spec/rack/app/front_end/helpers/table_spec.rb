require 'spec_helper'

describe Rack::App::FrontEnd::Helpers::Table do
  include_examples :string_formatter

  let(:instance) do
    o = Object.new
    o.extend(described_class)
    o
  end

  let(:attributes) { {} }

  describe '#table_by' do
    subject { instance.table_by(object, attributes) }

    context 'when object is an array of hash' do
      let(:object) { [{ hello: 'world' }, { hello: 'programming', col: 'val' }] }

      it 'should create a html table based on the array of has content' do
        is_expected.to eq uglier_html <<-HTML

            <table>

              <tr>
                <td>hello</td>
                <td>col</td>
              </tr>

              <tr>
                <td>world</td>
                <td/>
              </tr>

              <tr>
                <td>programming</td>
                <td>val</td>
              </tr>

            </table>

      HTML
      end

      context 'and attributes given' do
        let(:attributes) { { class: 'table' } }

        it 'should create a html table based on the array of has content' do
        is_expected.to eq uglier_html <<-HTML

            <table class="table">

              <tr>
                <td>hello</td>
                <td>col</td>
              </tr>

              <tr>
                <td>world</td>
                <td/>
              </tr>

              <tr>
                <td>programming</td>
                <td>val</td>
              </tr>

            </table>

      HTML
      end
      end
    end

    context 'when object is a hash' do
      let(:object) { { name: 'cat', lives: 9 } }

      it 'should create a html table based on the hash content' do
        is_expected.to eq uglier_html <<-HTML

            <table>

              <tr>
                <td>name</td>
                <td>cat</td>
              </tr>

              <tr>
                <td>lives</td>
                <td>9</td>
              </tr>

            </table>

      HTML
      end

      context 'and attributes given' do
        let(:attributes) { { class: 'table' } }

        it 'should create a html table based on the hash content' do
          is_expected.to eq uglier_html <<-HTML

            <table class="table">

              <tr>
                <td>name</td>
                <td>cat</td>
              </tr>

              <tr>
                <td>lives</td>
                <td>9</td>
              </tr>

            </table>

      HTML
        end
      end
    end
  end
end
