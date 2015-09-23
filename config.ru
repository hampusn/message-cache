require './api_base'
require './app'
run Rack::URLMap.new("/api" => Hampusn::MessageCache::APIBase.new,
                     "/" => Hampusn::MessageCache::App.new)
