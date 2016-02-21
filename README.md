# Rack::App::FrontEnd [![Build Status](https://travis-ci.org/adamluzsi/rack-app-front_end.rb.svg?branch=master)](https://travis-ci.org/adamluzsi/rack-app-front_end.rb)

This is an extend module for Rack::App to have FrontEnd framework extensions for the core app class

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rack-app-front_end'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rack-app-front_end

## Usage

```ruby

class App < Rack::App
  
  extend Rack::App::FrontEnd 
  
  mount_folder '/from/project/root/path'
  mount_folder 'relative/folder/from/this/file/to/folder'
  
  
  get '/some_url' do
    @items = []
    render 'some.html.erb'
  end
  
end

```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/rack-app-mvc. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.

