require 'sinatra/base'
require 'sinatra/activerecord'
require 'dotenv'
require 'haml'

Dotenv.load

# base.rb contains a subclass of Sinatra::Base
require './base'

Dir.glob("models/*.rb").each { |r| require_relative r }
Dir.glob("helpers/*.rb").each { |r| require_relative r }
Dir.glob("controllers/*.rb").each { |r| require_relative r }

module Hampusn
  module MessageCache
    class App < Hampusn::MessageCache::Base

      use Hampusn::MessageCache::Controllers::UserController
      use Hampusn::MessageCache::Controllers::RequestController

      get "/" do
        @title = "MessageCache"
        haml :index, layout: :'layouts/front'
      end

    end
  end
end