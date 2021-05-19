source 'https://rubygems.org'
# lc41 gem server, gems found here will be prioritized over rubygems
source 'https://VSjzUsyv5i25mygopyu7@gem.fury.io/lc41/'
ruby "2.6.2"

#dotenv recomends being the first gem included
gem 'dotenv-rails', groups: [:development, :test] # application environment vars

# RAILS DEFAULTS

gem 'rails', '~> 5.2.0'         # Provides rails framework
gem 'pg', '~> 0.18'             # Use postgres with Active Record
gem 'puma', '~> 4.3'            # Use Puma as the app server
gem 'sass-rails', '~> 5.0'      # Use SCSS for stylesheets
gem 'uglifier', '>= 1.3.0'      # Compresses javascript assets
gem 'jquery-rails'              # Use jquery as the Javascript library
gem 'turbolinks', '~> 5'        # Increases performance of web application
# gem 'redis', '~> 3.0'         # In memory datastore, required by actioncable
                                # and sidekiq
gem 'bootsnap'                  # faster app initialization

# TYEMILL CREATED GEMS

gem 'datum', source: 'https://VSjzUsyv5i25mygopyu7@gem.fury.io/lc41/' # Testing utilities
# gem 'jaunt'                   # Performant .xlsx file parsing

# OUR FAVORITE GEMS

gem 'devise', '~> 4.6.0'        # User authentication
gem 'pundit'                    # Controller action permissions
gem 'will_paginate'             # Simple pagination helpers
# gem 'sidekiq'                 # Enables ActiveJob
# gem 'sidekiq-status'          # Query jobs status and attributes
# gem 'sinatra', require: false # dependency of sidekiqs web console
# gem 'pg_search'               # database text search, multicolumn, etc.
# gem 'paperclip'               # file attachments to models

# FRONTEND

gem 'font-awesome-rails'        # Loads of icons

group :production do
  # gem 'postmark-rails', '>= 0.10.0'
end

group :development, :test do
  gem 'pry-byebug'              # Debugging console
  gem 'simplecov'               # Code coverage for tests
  gem 'selenium-webdriver'      # better webdriver for capybara
  gem 'capybara'                # integration testing tool
end

group :development do
  gem 'listen', '~> 3.0.5'      # Dependency of spring
end
