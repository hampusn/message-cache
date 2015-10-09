require 'sinatra/base'
require 'sinatra/activerecord'
require 'dotenv'
require 'haml'

Dotenv.load

Dir.glob("models/*.rb").each { |r| require_relative r }
Dir.glob("helpers/*.rb").each { |r| require_relative r }
Dir.glob("controllers/*.rb").each { |r| require_relative r }

module Hampusn
  module MessageCache
    class App < Sinatra::Base

      use Hampusn::MessageCache::Controllers::UserController
      use Hampusn::MessageCache::Controllers::RequestController

      get "/" do
        @title = "MessageCache"
        haml :index
      end

    end
  end
end