# Message Model

module Hampusn
  module MessageCache
    module Models
      class Message < ActiveRecord::Base
        belongs_to :user

      end
    end
  end
end
