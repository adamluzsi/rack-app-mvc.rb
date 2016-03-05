require 'spec_helper'

describe Rack::App::FrontEnd::Helpers::Boilerplate do

  include_examples :string_formatter

  let(:instance) do
    o = Object.new
    o.extend(described_class)
    o
  end

  describe '#table_by' do
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

  describe '#*_tag DSL' do

    it 'should create the html tags with syntax sugar with' do

      form_html = instance.form_tag(method: 'get', action: '/search', "accept-charset" => "UTF-8") do
        label_tag "Search for:", :for => "q"

        input_tag :name => "utf8", :type => "hidden", :value => "&#x2713;"

        input_tag :name => "commit", :type => "submit", :value => "Search"
      end

      expect(form_html).to eq uglier_html <<-HTML

        <form method="get" accept-charset="UTF-8" action="/search">
          <label for="q">Search for:</label>
          <input name="utf8" type="hidden" value="&#x2713;"/>
          <input name="commit" type="submit" value="Search"/>
        </form>

      HTML

    end

    context 'the form it self with no extra html attributes' do

      it 'should set the method and accept-charset by self' do

        form_html = instance.form_tag(action: '/search')

        expect(form_html).to eq uglier_html <<-HTML

          <form method="get" accept-charset="UTF-8" action="/search"/>

        HTML

      end

    end

  end

end