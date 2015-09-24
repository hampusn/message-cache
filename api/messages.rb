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
          before do
            if route.route_method == 'POST' && route.route_path == '/messages(.json)'
              # Normalize params from different sources so they can be inserted into 
              # messages table.
              
              # The main message text should be stored under the key 'message'. 
              # The rest of the data should be placed in a hash/array under the key 'meta'.

              normalizer_name = params[:normalizer]

              normalizer = get_normalizer(normalizer_name)

              # Couldn't pass params directly into normalizer.normalize
              # This trick seems to work though, no clue why
              p = params
              params = normalizer.normalize(p)
            end
          end
          
          desc "Return a list messages."
          params do
            optional :count, type: Integer, default: 10, values: 1..20
          end
          get do
            authenticate!

            messages = Message.where(user_id: @api_user.id).order(created_at: :desc).limit(api_params[:count])

            present messages, with: Entities::Message
          end

          desc "Create a new message."
          params do
            requires :message, type: String, default: ''
            optional :meta, type: Hash, default: {}
          end
          post do
            authenticate!

            message = Message.new

            message.user_id = @api_user.id
            message.message = api_params[:message]
            message.meta = api_params[:meta]

            message.save
          end

        end

      end
    end
  end
end
