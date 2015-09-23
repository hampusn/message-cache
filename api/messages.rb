# Messages Resource

require 'grape'
require 'json'

include Hampusn::MessageCache::Models

module Hampusn
  module MessageCache
    module API
      class Messages < Grape::API

        format :json

        helpers Hampusn::MessageCache::Helpers::APIHelpers

        resource :messages do
          
          desc "Return a list messages."
          params do
            optional :count, type: Integer, default: 10, values: 1..20
          end
          get :latest do
            authenticate!

            messages = Message.order(created_at: :desc).limit(api_params[:count])

            {results: messages, params: api_params}
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
