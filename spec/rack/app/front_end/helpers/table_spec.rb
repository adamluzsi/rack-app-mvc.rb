require 'spec_helper'

describe Rack::App::FrontEnd::Helpers::Table do

  include_examples :string_formatter

  let(:instance) do
    o = Object.new
    o.extend(described_class)
    o
  end

  describe '#create_table' do
    subject { instance.table_by(array_of_hash) }

    let(:array_of_hash) { [{:hello => 'world'}, {:hello => 'programming', :col => 'val'}] }

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
  end

end