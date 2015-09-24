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
              
              # 46 Elks post data:
              # 
              # - from:    +46704508449
              # - to:      +46766861001
              # - message: I want to buy 2 cartons of milk!

              # Slack post data:
              # 
              # - token:        XXXXXXXXXXXXXXXXXX
              # - team_id:      T0001
              # - team_domain:  example
              # - channel_id:   C2147483705
              # - channel_name: test
              # - timestamp:    1355517523.000005
              # - user_id:      U2147483697
              # - user_name:    Steve
              # - text:         googlebot: What is the air-speed velocity of an unladen swallow?
              # - trigger_word: googlebot:

              # The main message text should be stored under the key 'message'. 
              # The rest of the data should be placed in a hash/array under the key 'meta'.

              # Example result after normalization for a slack post:

              # params[:message] = params[:text]
              # params[:meta] = {
              #   token: 'XXXXXXXXXXXXXXXXXX',
              #   team_id: 'T0001',
              #   team_domain: 'example',
              #   channel_id: 'C2147483705',
              #   channel_name: 'test',
              #   timestamp: 1355517523.000005,
              #   user_id: 'U2147483697',
              #   user_name: 'Steve',
              #   trigger_word: 'googlebot:'
              # }
            end
          end
          
          desc "Return a list messages."
          params do
            optional :count, type: Integer, default: 10, values: 1..20
          end
          get do
            authenticate!

            messages = Message.where(user_id: @api_user.id).order(created_at: :desc).limit(api_params[:count])

            {results: messages, params: api_params}
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
