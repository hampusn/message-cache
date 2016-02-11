require 'grape'
require 'grape-entity'
require 'active_record'

Dir.glob("models/*.rb").each { |r| require_relative r }
Dir.glob("helpers/*.rb").each { |r| require_relative r }
Dir.glob("api/*.rb").each { |r| require_relative r }
Dir.glob("api/normalizers/*.rb").each { |r| require_relative r }
Dir.glob("api/entities/*.rb").each { |r| require_relative r }
Dir.glob("api/middlewares/*.rb").each { |r| require_relative r }

module Hampusn
  module MessageCache
    class APIBase < Grape::API

      helpers Hampusn::MessageCache::Helpers::UserHelpers

      use Hampusn::MessageCache::API::Middlewares::CustomStatusCodeMiddleware

      http_basic do |username, key|
        user = User.find_by username: username

        authenticated = user && !!user.key && user.key == key && user.activated

        if authenticated
          @api_user = user
        else
          @api_user = false
        end

        authenticated
      end

      mount Hampusn::MessageCache::API::Messages

    end
  end
end