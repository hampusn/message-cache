require 'grape'
require 'active_record'

Dir.glob("models/*.rb").each { |r| require_relative r }
Dir.glob("api/*.rb").each { |r| require_relative r }

module Hampusn
  module MessageCache
    class API_Base < Grape::API

      use Rack::Auth::Basic, "Protected Area" do |user, pass|
        
        # TODO: Match against database instead 
        #       of these hardcoded values
        user2 = 'devuser'
        pass2 = 'devpass' 

        user == user2 && pass == pass2
      end

      mount Hampusn::MessageCache::API::Messages

    end
  end
end