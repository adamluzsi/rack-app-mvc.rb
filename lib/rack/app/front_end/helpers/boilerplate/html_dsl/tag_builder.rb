module Rack::App::FrontEnd::Helpers::Boilerplate::HtmlDsl::TagBuilder

  extend self

  def build(tag_name, *args, &block)

    content = args.select { |a| a.is_a?(String) }.join
    html_properties = args.select { |a| a.is_a?(Hash) }.reduce({}) do |properties, hash|
      hash.each { |k, v| properties.merge!(k.to_s => v) }
      properties
    end

    html = ''
    html << "<#{tag_name}"

    unless html_properties.empty?
      html << ' '
      html << html_properties.reduce([]) { |m, (k, v)| m << "#{k}=#{v.to_s.inspect}" }.join(' ')
    end

    if not content.empty? or not block.nil?
      html << ">"
      html << content
      html << Rack::App::FrontEnd::Helpers::Boilerplate::HtmlDsl::Block.new(&block).to_s unless block.nil?
      html << "</#{tag_name}>"
    else
      html << "/>"
    end

    return html
  end


end
