# User Controller

include Hampusn::MessageCache::Models

module Hampusn
  module MessageCache
    module Controllers
      class UserController < Sinatra::Base

        helpers Hampusn::MessageCache::Helpers::UserHelpers

        post '/user/login' do
          # Handle authentication
        end

        get '/user/register' do
          # Register view with form
          "Register"
        end

        post '/user/register' do
          
          salt = generate_new_salt
          password = generate_password_hash params[:password], salt

          user = User.new

          user.username = params[:username]
          user.email = params[:email]
          user.password = password
          user.salt = salt
          user.key = params[:key]

          user.save

          redirect '/user/register'
        end

        post '/user/reset-password' do
          # ...
        end

      end
    end
  end
end
