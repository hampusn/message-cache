# User Model

module Hampusn
  module MessageCache
    module Models
      class User < ActiveRecord::Base
        has_many :messages, dependent: :destroy

        validates_uniqueness_of :username
        validates_uniqueness_of :email
      end
    end
  end
end
