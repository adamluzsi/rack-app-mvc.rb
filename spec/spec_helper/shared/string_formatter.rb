shared_examples_for :string_formatter do

  def uglier_html(nice_html)
    nice_html.gsub("\n",'').strip.gsub(/(?<=\w>)(\s*)(?=<\/?\w)/,'').gsub(/>\s*</,'><')
  end

end