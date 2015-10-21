require './link-sniffer'
require 'sinatra'
require 'sinatra/cross_origin'
require 'net/http'

class LinkSnifferServer < Sinatra::Base
  register Sinatra::CrossOrigin

  def initialize
    super
    @logger = getLogger
    @parser = HtmlParser.new
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
    @logger.info('API') { "Asked: #{url}" }

    url = params[:url]
    if !url.nil?
      uri = URI(url)
      response = Net::HTTP.get(uri)
      @parser.parse(response)
      @parser.getOGDatas.to_json
    else
      400
    end
  end
end
