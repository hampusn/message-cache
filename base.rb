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

      register do
        def use_basic_auth (use_basic_auth)
          condition do
            basic_auth_protected!
          end
        end

        def require_login_or_redirect_to (redirect_route)
          condition do
            redirect redirect_route unless send("is_user?")
          end
        end
      end

      helpers do
        def basic_auth_protected!
          unless basic_auth_authorized?
            response['WWW-Authenticate'] = %(Basic realm="Authentication required.")
            throw(:halt, [401, "Oops... we need your login name & password\n"])
          end
        end

        def basic_auth_authorized?
          @auth ||=  Rack::Auth::Basic::Request.new(request.env)

          unless ENV['ADMIN_AUTH'].blank?
            admin_auth = ENV['ADMIN_AUTH'].unpack("m*").first.split(/:/, 2)
          end

          @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == admin_auth
        end

        def is_user?
          @user != nil
        end
      end

      before do
        @user = User.find_by id: session[:user_id]
      end

    end
  end
end