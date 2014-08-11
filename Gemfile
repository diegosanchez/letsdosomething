source 'https://rubygems.org'

gem 'rails', '3.2.13'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'pg'
gem 'devise'
gem 'jquery-rails'
gem 'dropbox-sdk'
gem 'recaptcha', :require => 'recaptcha/rails'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'

  gem 'bootstrap-sass', '~> 3.1.0'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end


group :test do
  gem "cucumber-rails", :require => false
  gem "simplecov"
  gem 'sqlite3'
  gem "database_cleaner"
  gem "faker" 
  gem "capybara"
  gem "capybara-email"
  gem "rspec-mocks"
  gem "selenium-webdriver"
  gem "vcr"
  gem "webmock"
end

gem "rspec-rails", :group => [ :development, :test ]
gem "dotenv-rails", :group => [ :development, :test ]
gem "debugger", :group => [ :development ]


