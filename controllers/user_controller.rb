# User Controller

include Hampusn::MessageCache::Models

module Hampusn
  module MessageCache
    module Controllers
      class UserController < Sinatra::Base

        helpers Hampusn::MessageCache::Helpers::UserHelpers

      end
    end
  end
end