require 'pwd'
module Rack::App::FrontEnd::Utils

  extend self

  def get_full_path(file_path,caller_index=1)
    return nil if file_path.nil?
    if file_path.to_s[0] == File::Separator
      PWD.join(file_path)
    else
      File.join(File.dirname(caller[caller_index].split(':')[0]),file_path)
    end
  end

end