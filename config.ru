require './api_base'
require './app'
run Rack::URLMap.new("/api" => Hampusn::MessageCache::API_Base.new,
                     "/" => Hampusn::MessageCache::App.new)
