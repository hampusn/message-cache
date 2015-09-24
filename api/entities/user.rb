# User Entity

module Hampusn
  module MessageCache
    module API
      module Entities
        class User < Grape::Entity
          expose :id
          expose :username
        end
      end
    end
  end
end
