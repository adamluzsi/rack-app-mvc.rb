module Rack::App::FrontEnd::SyntaxSugar::DSL

  def helper(symbolic_name)
    module_name = "Rack::App::FrontEnd::Helpers::#{symbolic_name.to_s.split('_').collect(&:capitalize).join}"
    ObjectSpace.each_object(Module).select{|m| not m.is_a?(Class) }.find {|m| m.to_s == module_name }
  end

end