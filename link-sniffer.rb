require 'bundler'
require 'logger'
require 'singleton'

APP_ENV = ENV['APP_ENV'] || ENV['RACK_ENV'] || 'development'

Bundler.require(:default, APP_ENV)
Dotenv.load unless APP_ENV == 'production'

Dir.mkdir('log') if !Dir.exist?('log')

if APP_ENV == 'development' || APP_ENV == 'test'
  FactoryGirl.definition_file_paths << Pathname.new(Dir.pwd).join("spec/factories")
end

def getLogger
  if APP_ENV == 'production'
    logger = Logger.new(STDOUT)
    logger.level = Logger::INFO
  else
    logger = Logger.new("log/#{APP_ENV}.log")
    logger.level = Logger::DEBUG
  end
  logger
end
