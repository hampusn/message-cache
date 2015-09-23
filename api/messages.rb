# Messages Resource

require 'grape'
require 'json'

include Hampusn::MessageCache::Models

module Hampusn
  module MessageCache
    module API
      class Messages < Grape::API

        format :json

        helpers do
          def authenticate!
            error!('401 Unauthorized', 401) unless @api_user
          end
        end

        resource :messages do
          
          desc "Return a list messages."
          get :latest do
            authenticate!
            
            Message.limit(20)
          end

          post do
            authenticate!

            message = Message.new

            message.user_id = @api_user.id
            message.message = params[:message]

            message.save
          end

        end

      end
    end
  end
end
