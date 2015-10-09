# Request Controller

require 'securerandom'

include Hampusn::MessageCache::Models

module Hampusn
  module MessageCache
    module Controllers
      class RequestController < Sinatra::Base

        post '/request' do
          reg_key = SecureRandom.hex

          req = Request.new

          req.email = params[:email]
          req.registration_key = reg_key

          req.save

          redirect '/'
        end

      end
    end
  end
end
