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

          def api_params
            @api_params ||= declared(params) # , include_missing: false
          end
        end

        resource :messages do
          
          desc "Return a list messages."
          params do
            optional :count, type: Integer, default: 10, values: 1..20
          end
          get :latest do
            authenticate!

            messages = Message.limit(api_params[:count])
            
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
