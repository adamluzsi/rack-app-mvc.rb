require 'spec_helper'

describe Rack::App::FrontEnd::Helpers::HtmlDsl do

  include_examples :string_formatter

  let(:instance) do
    o = Object.new
    o.extend(described_class)
    o
  end

  describe '#form_tag' do

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