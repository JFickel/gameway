source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.3'
gem 'ember-rails'
gem 'ember-source', '1.4.0'
gem 'active_model_serializers'
gem 'gon', '5.0.4'
gem 'devise', '3.2.3'

# Use sqlite3 as the database for Active Record
gem 'pg'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks is bad!
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :production, :staging do
  gem 'rails_12factor'
end

group :development, :test do
  gem 'debugger'
  gem 'simplecov'

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
end
