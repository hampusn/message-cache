# Messages Resource

require 'grape'
require 'json'

include Hampusn::MessageCache::Models

module Hampusn
  module MessageCache
    module API
      class Messages < Grape::API

        format :json

        helpers do
          def authenticate!
            true
          end
        end

        resource :messages do
          
          desc "Return a list messages."
          get :latest do
            Message.limit(20)
          end

        end

      end
    end
  end
end
