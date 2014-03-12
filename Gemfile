source 'https://rubygems.org'
ruby '2.0.0'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.3'

gem 'sass-rails', '~> 4.0.0'

# Use typeahead.js for autocomplete
gem 'twitter-typeahead-rails'

# Use Hogan for typeahead templates
gem 'hogan_assets'

# Use Haml for html
gem 'haml-rails'

# Use devise for authentication
gem 'devise', '3.2.3'

# Postgres for heroku
gem 'pg'

# Use ActiveModel::Serializers for JSON responses
gem 'active_model_serializers'

# Working with Ember.js
gem 'ember-rails'
gem 'ember-source', '1.2.0'

# Using FB and twitch omniauth
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-twitch_oauth2'

# Use rails admin for back-end
gem 'rails_admin'

# Use carrierwave for images
gem 'fog'
gem 'carrierwave'
gem 'rmagick', '2.13.2', :require => 'RMagick'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# Use detect_timezone_rails to detect a user's computer time through JavaScript
gem 'detect_timezone_rails'

# Use PostgreSQL's full text search
gem 'pg_search'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'

group :production, :staging do
  gem 'rails_12factor'
end

# Nice memcached driver
gem 'dalli'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

# gem 'bootstrap-sass', git: 'git://github.com/intridea/bootstrap-sass.git', branch: '3.0.0-wip'

# Use facebook library to add high schools, colleges, friends
gem "koala"

# Game API Wrappers
gem 'ruby-lol'
gem 'starcraft2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development, :test do
  gem 'debugger'

  gem 'rspec-rails'
  gem 'shoulda'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'pry-rails'

  gem 'better_errors' # go to /__better_errors to see the last error
  gem 'binding_of_caller'

  gem 'guard-rspec'
  gem 'spork-rails'
  gem 'guard-spork'

  gem 'simplecov'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development
