class Rack::App::FrontEnd::Template::Scope

  def extended_modules
    class << self
      self
    end.included_modules
  end

  def inherit_modules!(object)
    class << object
      self
    end.included_modules.each do |module_constant|
      extend(module_constant)
    end
  end
  
  def inherit_instance_variables!(object)
    object.__send__(:instance_variables).each do |instance_variable|
      value = object.__send__(:instance_variable_get, instance_variable)
      instance_variable_set(instance_variable, value)
    end
  end

end