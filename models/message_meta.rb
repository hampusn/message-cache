# Message Meta Model

module Hampusn
  module MessageCache
    module Models
      class MessageMeta < ActiveRecord::Base
        self.table_name = "message_metas"

        belongs_to :message
      end
    end
  end
end
