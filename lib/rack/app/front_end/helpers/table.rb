module Rack::App::FrontEnd::Helpers::Table
  module Builder
    extend(self)

    def from_array_of_hash(array_of_hash)
      headers = array_of_hash.each_with_object([]) do |hash, trs|
        trs.push(*hash.keys)
        trs.uniq!
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

    def from_hash(hash)
      o = Object.new
      o.extend(Rack::App::FrontEnd::Helpers::HtmlDsl)

      table_html = o.__send__ :table_tag do
        hash.each do |key, value|
          tr_tag do
            td_tag String(key)
            td_tag String(value)
          end
        end
      end

      table_html
    end
  end

  def table_by(object)
    if object.is_a?(Array) && object.all? { |e| e.is_a?(Hash) }
      Builder.from_array_of_hash(object)
    elsif object.is_a?(Hash)
      Builder.from_hash(object)
    else
      raise("don't know how to build table from this: #{object}")
    end
  end
end
