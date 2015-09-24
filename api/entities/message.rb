# Message Entity

require_relative 'user.rb'

module Hampusn
  module MessageCache
    module API
      module Entities
        class Message < Grape::Entity
          expose :id
          expose :message
          expose :meta
          expose :user, using: Entities::User
          expose :created_at
        end
      end
    end
  end
end
