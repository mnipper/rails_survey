source 'https://rubygems.org'
ruby "2.0.0"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

gem 'pg', group: [:production]

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

gem "rubyzip", "~> 1.1.2"
gem 'zip-zip'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

gem 'angularjs-rails', '~> 1.0.7'

# Strong parameters is still glitchy with nested attributes
gem 'protected_attributes'

gem 'annotate', ">=2.5.0"

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

gem "rails_config"

gem "twitter-bootstrap-rails"

# User authentication
gem 'devise'

gem 'paper_trail', '>= 3.0.0.rc2'

group :test do
  gem 'rspec-rails', '~> 2.0'
  gem 'rspec-mocks'
  gem "factory_girl_rails", "~> 4.0"
  gem 'database_cleaner', '~> 1.0'
  gem 'capybara'
  gem 'selenium-webdriver', '~> 2.39'
end

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
gem 'capistrano', group: :development

gem 'exception_notification'
gem 'sqlite3', group: [:development, :test]
gem 'chosen-rails'
gem 'activeadmin', github: 'gregbell/active_admin'
gem 'paranoia', '~> 2.0'
gem 'pundit'
gem 'groupdate', github: 'mieko/groupdate', :branch => 'sqlite3'
gem 'paperclip', '~> 4.1.0'
gem "redis", "~> 3.0.7"
gem 'role_model', '~> 0.8.1'
gem 'sidekiq', '~> 3.0.0'

group :production do
  gem 'rails_12factor'
end

group :development do
  gem 'debugger', group: [:development]
  gem 'better_errors'
  gem 'binding_of_caller'
end
