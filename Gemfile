source 'http://rubygems.org'
ruby '2.1.5'

# Rails
gem 'rails', '4.2.0'

# DB Connector
gem 'mysql2'

# Templates for generating JSON and other data output
# see https://github.com/gowalla/boxer
gem 'boxer'
gem 'json'
gem 'jbuilder'

# Public activity
gem 'public_activity'

# Version history Gem
gem 'paper_trail'

# Makes nested forms easier
gem 'cocoon'

# Support for social media service plugins
# gem 'twitter'
# gem 'hyper-graph'

# Devise does user authentication mechanisms for us
gem "devise"
# Integrate devise with a CAS service (here we use OMB Max)
gem 'devise_cas_authenticatable'

# Tagging support
gem 'acts-as-taggable-on'

# Pagination
gem 'kaminari'

# Swagger generation
gem 'swagger-docs'

# Rack CORS. Prevents need to do this in application controller, lets us do it for public directory
gem 'rack-cors', :require => 'rack/cors'

######
# Assets / Assets related gems
######
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end
gem 'font-awesome-rails'
gem 'bootstrap-sass', '~> 3.3.3'
gem 'morrisjs-rails'
gem 'raphael-rails'
gem 'jquery-rails'
gem 'jquery-tokeninput-rails'
gem "jqcloud-rails"

######
# End Assets / Assets related gems
######

######
# Development Gems
######
group :development do
  gem 'annotate', :git => 'git://github.com/ctran/annotate_models.git'
  gem 'faker'
  gem 'jazz_hands', github: 'nixme/jazz_hands', branch: 'bring-your-own-debugger'
  gem 'pry-byebug'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'pry'
  gem 'letter_opener'
end
######
# End Development Gems
######
######
# Development and Testing Gems
######
group :development, :test do
  gem 'rspec-rails', '~> 3.0'
end
######
# End Development and Testing Gems
######
######
# Testing Gems
######
group :test do
  # bundlePretty printed test output
  gem 'factory_girl_rails'
end
######
# End Testing Gems
######
