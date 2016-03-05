module Rack::App::FrontEnd::Helpers::Boilerplate::HtmlDsl
  UnImplementedError = Class.new(StandardError)

  require 'rack/app/front_end/helpers/boilerplate/html_dsl/block'
  require 'rack/app/front_end/helpers/boilerplate/html_dsl/tag_builder'

  def self.build(method_name, *args, &block)
    case method_name.to_s

      when /_tag$/
        tag_name = method_name.to_s.sub(/_tag$/, '')
        TagBuilder.build(tag_name,*args,&block)

      else
        raise(UnImplementedError)

    end
  end

  def method_missing(method_name,*args,&block)
    Rack::App::FrontEnd::Helpers::Boilerplate::HtmlDsl.build(method_name,*args,&block)
  rescue UnImplementedError
    super
  end

end
