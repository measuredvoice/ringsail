source 'http://rubygems.org'

gem 'rails', '3.1.1'
gem 'mysql2'

gem 'passenger', '3.0.11'

# Templates for generating JSON and other data output
# see https://github.com/gowalla/boxer
gem 'boxer'
gem 'json'

# Support for social media service plugins
gem 'twitter'
gem 'hyper-graph'

# Automatic admin interface
gem 'rails_admin', :git => 'git://github.com/sferik/rails_admin.git'
gem "devise"

# Tagging support
gem 'acts-as-taggable-on', '~>2.1.0'

# API pagination
gem 'kaminari', '~> 0.12'

# Location support
gem 'yahoo-geoplanet', :git => 'git://github.com/measuredvoice/yahoo-geoplanet.git'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.4'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

group :development do
  gem 'rspec-rails', '2.6.1'
  gem 'annotate', :git => 'git://github.com/ctran/annotate_models.git'
  gem 'faker', '0.3.1'
  gem 'ruby-debug19'
end

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
  gem 'rspec-rails', '2.6.1'
  gem 'webrat', '0.7.1'
  gem 'autotest', '4.4.6'
  gem 'autotest-rails-pure', '4.1.2'
  gem 'autotest-fsevent', '0.2.4'
  gem 'autotest-growl', '0.2.9'
end

