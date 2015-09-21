require 'grape'
require 'active_record'

Dir.glob("models/*.rb").each { |r| require_relative r }
Dir.glob("api/*.rb").each { |r| require_relative r }

module Hampusn
  module MessageCache
    class API_Base < Grape::API

      mount Hampusn::MessageCache::API::Messages

    end
  end
end