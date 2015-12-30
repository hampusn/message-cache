# Request Controller

require 'securerandom'

include Hampusn::MessageCache::Models

module Hampusn
  module MessageCache
    module Controllers
      class RequestController < Hampusn::MessageCache::Base

        post '/request' do
          unless User.exists?(email: params[:email])
            req = Request.new

            req.email = params[:email]
            req.registration_key = SecureRandom.hex

            req.save
          end

          redirect '/'
        end

      end
    end
  end
end
