source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Avo
gemspec path: './../avo'
# Pluggy is Avo's the test plugin and we need to require it in this app if we want to have it available
gem "pluggy", path: "./../avo/pluggy"
gemspec path: './../avo-advanced'
gemspec path: './../avo-pro'
gemspec path: './../avo-dashboards'
gemspec path: './../avo-dynamic_filters'
gemspec path: './../avo-menu'
gemspec path: './../avo_nested_resources'

ruby "3.2.0"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.4", ">= 7.0.4.2"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem "jsbundling-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem "cssbundling-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Sass to process CSS
# gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  # Debuguger
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'ruby-debug-ide', '~> 0.7.3'
  gem 'debase', '~> 0.2.5.beta2'
  # End Debuger

  gem "faker", require: false
  gem "i18n-tasks", "~> 1.0.12"
  gem "erb-formatter"
  gem "solargraph"
  gem "solargraph-rails"

  gem "factory_bot_rails"

  gem "appraisal"
end

gem "dotenv-rails"
group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  gem "standard"

  # Release helper
  gem "bump", require: false
  gem "gem-release", require: false

  gem "annotate"

  # gem 'rack-mini-profiler'
  # gem 'memory_profiler'
  # gem 'stackprof'
  # gem 'ruby-prof'

  # gem 'pry-rails'

  gem "htmlbeautifier"

  gem "hotwire-livereload", "~> 1.2.3"

  gem "brakeman"

  gem "rubocop"
  gem "rubocop-shopify", require: false
end

group :test do
  gem "rspec-rails", "~> 6.0.0"
  gem "rails-controller-testing"
  # Adds support for Capybara system testing and selenium driver
  gem "capybara"
  gem "selenium-webdriver"
  # Easy installation and use of web drivers to run system tests with browsers
  gem "webdrivers"
  gem "fuubar"
  gem "simplecov", require: false
  gem "simplecov-cobertura"
  gem "webmock"
  gem "spring-commands-rspec"
  gem "launchy", require: false

  gem "test-prof"
  gem "database_cleaner"
end

gem 'devise'

### bud gems
gem "awesome_print"
gem "dry-initializer"
gem "activesupport"
gem "dry-cli"
gem "paint"

gem "tty-command"

# Other Avo test gems
# Avo file filed requires this gem
# Use Active Storage variant
gem "image_processing", "~> 1.12"
gem 'acts_as_list'
# Search
gem 'ransack'
# Countries
gem 'countries'

gem 'friendly_id', '~> 5.4.0'

gem 'acts-as-taggable-on', '~> 9.0'

# Dashboards
gem "chartkick"

# Authorization
gem "pundit"


# gem "avo", path: './../../avo'
# gem "avo_filters", path: './../../avo_filters'
