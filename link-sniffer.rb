require 'bundler'
require 'logger'
require 'singleton'

class LinkSniffer
  class Logger
    include Singleton

    def get
      if APP_ENV == 'production'
        @logger = Logger.new(STDOUT)
        @logger.level = Logger::INFO
      else
        @logger = Logger.new("log/#{APP_ENV}.log")
        @logger.level = Logger::DEBUG
      end

      @logger
    end
  end

  def self.logger
    Logger.instance.get
  end
end


APP_ENV = ENV['APP_ENV'] || ENV['RACK_ENV'] || 'development'

Bundler.require(:default, APP_ENV)
Dotenv.load unless APP_ENV == 'production'

Dir.mkdir('log') if !Dir.exist?('log')

if APP_ENV == 'development' || APP_ENV == 'test'
  FactoryGirl.definition_file_paths << Pathname.new(Dir.pwd).join("spec/factories")
end

# require_all 'shared/models'
# require_all 'lib/models'

# require_all 'lib/modules'

# require_all 'shared/helpers'
# require_all 'lib/helpers'

# require_all 'lib/scripts'


