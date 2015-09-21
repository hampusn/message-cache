require 'sinatra/base'
require 'sinatra/activerecord'

Dir.glob("models/*.rb").each { |r| require_relative r }
Dir.glob("controllers/*.rb").each { |r| require_relative r }

module Hampusn
  module MessageCache
    class App < Sinatra::Base

      # use Hampusn::MessageCache::Controllers:: ...

      get "/" do
        "MessageCache"
      end

    end
  end
end