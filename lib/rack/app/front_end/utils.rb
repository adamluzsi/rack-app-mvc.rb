module Rack::App::FrontEnd::Utils

  extend self

  def get_full_path(file_path,caller_index=1)
    return nil if file_path.nil?
    if file_path.to_s[0] == File::Separator
      Rack::App::Utils.pwd(file_path)
    else
      File.join(File.dirname(caller[caller_index].split(':')[0]),file_path)
    end
  end

  # Based on ActiveSupport, removed inflections.
  # https://github.com/rails/rails/blob/v4.1.0.rc1/activesupport/lib/active_support/inflector/methods.rb
  def underscore(camel_cased_word)
    word = camel_cased_word.to_s.gsub('::', '/')
    word.gsub!(/([A-Z\d]+)([A-Z][a-z])/, '\1_\2')
    word.gsub!(/([a-z\d])([A-Z])/, '\1_\2')
    word.tr!("-", "_")
    word.downcase!
    word
  end

end