source "https://rubygems.org"

ruby '2.1.2'

gem 'bugsnag'
gem 'rake'
gem 'require_all'
gem "sinatra"
gem 'awesome_print'
gem 'rack-parser', :require => 'rack/parser'
gem 'pry-byebug'
gem "sinatra-cross_origin", "~> 0.3.1"
gem 'nokogiri'

group :development do
  gem 'annotate'
  # gem 'mina'
  # gem 'squasher'
  # gem 'rerun'
end

group :development, :test do
  gem 'factory_girl'
  gem 'faker'
  gem 'foreman'
  gem 'dotenv'
end

group :test do
  gem 'rspec'
  gem 'shoulda-matchers', require: false
  gem "rack-test"
  gem "webmock"
end
