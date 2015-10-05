# Message Entity

require_relative 'user.rb'
require_relative 'message_meta.rb'

module Hampusn
  module MessageCache
    module API
      module Entities
        class Message < Grape::Entity
          expose :id
          expose :message
          expose :message_metas, as: :meta, using: Entities::MessageMeta, if: lambda { |instance, options|
            !!options[:with_meta]
          }
          expose :user, using: Entities::User, if: lambda { |instance, options|
            !!options[:with_user]
          }
          expose :created_at
        end
      end
    end
  end
end
