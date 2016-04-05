require(File.join(File.dirname(__FILE__),'rack_app_inheritance_parent'))
class RackAppInheritanceChild < RackAppInheritanceParent

  get '/say' do
    render('say.html')
  end

  get '/helper' do
    render 'hello.html.erb'
  end

end