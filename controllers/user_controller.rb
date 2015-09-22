# User Controller

include Hampusn::MessageCache::Models

module Hampusn
  module MessageCache
    module Controllers
      class UserController < Sinatra::Base

        helpers Hampusn::MessageCache::Helpers::UserHelpers

        post '/user/login' do
          # Handle authentication
        end

        post '/register' do
          # Handle register
        end

        post '/reset-password'
          # ...
        end

      end
    end
  end
end