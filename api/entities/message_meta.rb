# MessageMeta Entity

module Hampusn
  module MessageCache
    module API
      module Entities
        class MessageMeta < Grape::Entity
          expose :key
          expose :value
        end
      end
    end
  end
end
