# Request Model

module Hampusn
  module MessageCache
    module Models
      class Request < ActiveRecord::Base
        validates_uniqueness_of :email
      end
    end
  end
end
