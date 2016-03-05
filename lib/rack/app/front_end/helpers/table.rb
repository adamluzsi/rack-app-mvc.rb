module Rack::App::FrontEnd::Helpers::Table

  def table_by(array_of_hash)

    headers = array_of_hash.reduce([]) do |trs, hash|
      trs.push(*hash.keys)
      trs.uniq!
      trs
    end

    o = Object.new
    o.extend(Rack::App::FrontEnd::Helpers::HtmlDsl)

    table_html = o.__send__ :table_tag do

      tr_tag do
        headers.each do |header|
          td_tag String(header)
        end
      end

      array_of_hash.each do |hash|
        tr_tag do
          headers.each do |header|
            td_tag String(hash[header])
          end
        end
      end

    end

    table_html
  end

end