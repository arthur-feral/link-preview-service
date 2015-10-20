ENV['APP_ENV'] ||= 'test'

require './link-sniffer'
require 'shoulda/matchers'
require 'sinatra'
require "sinatra/base"
require 'rack/test'
require "webmock/rspec"

Dir[Dir.pwd.concat("/lib/**/*.rb")].each { |f| require f }
Dir[Dir.pwd.concat("/spec/support/**/*.rb")].each { |f| require f }

def read_file(*path)
  data = nil
  File.open(File.join(path), 'r') { |f| data = f.read }
  return data
end

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include Rack::Test::Methods
end

FactoryGirl.find_definitions
