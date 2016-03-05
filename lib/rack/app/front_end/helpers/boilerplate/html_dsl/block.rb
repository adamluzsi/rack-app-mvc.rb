class Rack::App::FrontEnd::Helpers::Boilerplate::HtmlDsl::Block

  def initialize(&block)
    @html = ''
    instance_exec(&block)
  end

  def to_s
    @html
  end

  def method_missing(method_name, *args, &block)
    @html << ::Rack::App::FrontEnd::Helpers::Boilerplate::HtmlDsl.build(method_name, *args, &block)
  rescue ::Rack::App::FrontEnd::Helpers::Boilerplate::HtmlDsl::UnImplementedError
    super
  end

end