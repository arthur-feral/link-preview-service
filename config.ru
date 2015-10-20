require './lib/server'

use Rack::Parser, :content_types => {
  'application/json'  => Proc.new { |body| JSON.parse body }
}

run LinkSnifferServer
