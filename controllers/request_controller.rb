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

          flash[:notice] = "Request recived."

          redirect '/'
        end

        post '/request/approve', use_basic_auth: true do
          # protected!

          request = Request.where(email: params[:email]).take

          unless request.nil?
            request.approved = true

            request_saved = request.save

            if request_saved
              flash[:success] = "Request approved."

              redirect '/'
            end
          end

          flash[:error] = "Request failed."

          redirect '/'
        end

      end
    end
  end
end
