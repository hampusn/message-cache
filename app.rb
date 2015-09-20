require 'grape'
require 'active_record'

Dir.glob("models/*.rb").each { |r| require_relative r }
Dir.glob("controllers/*.rb").each { |r| require_relative r }

module Hampusn
  module MessageCache
    class App < Grape::API

      mount Hampusn::MessageCache::Controllers::MessagesController

      get "/" do
        "Messages Cache"
      end

      # Boot it up!
      run! if __FILE__ == $0
    end
  end
end