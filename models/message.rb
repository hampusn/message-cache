# Message Model

require_relative 'message_meta.rb'

module Hampusn
  module MessageCache
    module Models
      class Message < ActiveRecord::Base
        has_many :message_metas, dependent: :destroy
        belongs_to :user
      end
    end
  end
end
