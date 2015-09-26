# Message Meta Model

module Hampusn
  module MessageCache
    module Models
      class MessageMeta < ActiveRecord::Base
        belongs_to :message
      end
    end
  end
end
