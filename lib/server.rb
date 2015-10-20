require 'sinatra'
require 'sinatra/cross_origin'
require './link-sniffer'

class LinkSnifferServer < Sinatra::Base
  register Sinatra::CrossOrigin
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
    LinkSniffer.logger.info('API') { "Asked: #{url}" }
    { app_ids: app_ids }.to_json
  end
end
