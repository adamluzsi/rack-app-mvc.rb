module Rack::App::FrontEnd::Utils
  extend self

  def link_instance_variables(from, to)
    from.__send__(:instance_variables).each do |instance_variable|
      value = from.__send__(:instance_variable_get, instance_variable)
      to.__send__(:instance_variable_set, instance_variable, value)
    end
  end

end