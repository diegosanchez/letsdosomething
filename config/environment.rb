# Load the rails application
require File.expand_path('../application', __FILE__)
require 'dotenv'

Dotenv.load ".env.#{ENV['RAILS_ENV']}", ".env"

# Initialize the rails application
Letsdosomething::Application.initialize!
