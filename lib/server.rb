require './link-sniffer'
require 'sinatra'
require 'sinatra/cross_origin'
require 'httpclient'

class LinkSnifferServer < Sinatra::Base
  register Sinatra::CrossOrigin

  def initialize
    super
    @logger = getLogger
    @parser = HtmlParser.new
    @httpclient = HTTPClient.new
  end

  configure do
    enable :cross_origin
  end

  options "/" do
    cross_origin :allow_origin => :any,
      :allow_methods => [:get, :options],
      :allow_credentials => true,
      :expose_headers => [],
      :allow_headers => ["accept", "x-csrf-token", "authorization", "version"],
      :max_age => "0"
  end

  get "/" do
    url = params[:url]
    if !url.nil?
      begin
        response = @httpclient.get url, :follow_redirect => true
        return @parser.parse(response.body).getOGDatas.to_json
      rescue TooManyRedirect => e
        @logger.error('API') { "Error: #{e.message}" }
        @logger.error('API') { "Error: #{e.backtrace.inspect}" }
        return 500
      end
    else
      400
    end
  end
end
