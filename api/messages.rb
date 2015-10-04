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

        # /messages
        # Resource for messages.
        resource :messages do
          before do
            if route.route_method == 'POST' && route.route_path == '/messages(.json)'
              # Normalize params from different sources so they can be inserted into 
              # messages table.
              # 
              # See Hampusn::MessageCache::API::Normalizers::GenericNormalizer for an example.
              
              normalizer_name = params[:normalizer]
              normalizer = get_normalizer(normalizer_name)

              # Couldn't pass params directly into normalizer.normalize
              # This trick seems to work though, no clue why
              p = params
              params = normalizer.normalize(p)

              # Add the normalizer to the meta hash so it will later 
              # be saved as a MessageMeta.
              if allowed_normalizer? normalizer_name
                params[:meta][:normalizer] = normalizer_name
              else
                params[:meta] = {} unless params[:meta].is_a?(Hash)
                params[:meta][:normalizer] = 'generic'
              end
            end
          end
          
          desc "Return a list messages."
          params do
            optional :count, type: Integer, default: 10, values: 1..20
            optional :meta, type: Hash
            optional :with_meta, type: Boolean, default: true
          end
          get do
            authenticate!

            if api_params[:meta]
              conditions = {
                message_metas: {},
                messages: {
                  user_id: @api_user.id
                }
              }

              # This will probably not work since we want an 
              # OR operator between each condition.
              # A single meta works though!
              # 
              # ...Should probably be fixed later.
              api_params[:meta].each do |key, value|
                conditions[:message_metas][:key] = key
                conditions[:message_metas][:value] = value
              end

              messages = Message.joins(:message_metas).where(conditions).order(created_at: :desc).limit(api_params[:count])
            else
              messages = Message.where(user_id: @api_user.id).order(created_at: :desc).limit(api_params[:count])
            end


            present messages, with: Entities::Message, with_meta: api_params[:with_meta]
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

            api_params[:meta].each do |key, value|
              message.message_metas.build(key: key, value: value)
            end

            Message.transaction do
              message.save
            end

            present message, with: Entities::Message
          end

        end

      end
    end
  end
end
