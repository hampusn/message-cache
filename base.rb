require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/partial'

module Hampusn
  module MessageCache
    class Base < Sinatra::Base
      set :root, File.dirname(__FILE__)
      set :sessions, true
      set :haml, :layout => :'layouts/default'

      register Sinatra::Flash
      register Sinatra::Partial

      def authorized?
        @auth ||=  Rack::Auth::Basic::Request.new(request.env)

        unless ENV['ADMIN_AUTH'].blank?
          admin_auth = ENV['ADMIN_AUTH'].unpack("m*").first.split(/:/, 2)
        end

        @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == admin_auth
      end

      def protected!
        unless authorized?
          response['WWW-Authenticate'] = %(Basic realm="Authentication required.")
          throw(:halt, [401, "Oops... we need your login name & password\n"])
        end
      end

    end
  end
end