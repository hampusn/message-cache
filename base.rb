require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/partial'

module Hampusn
  module MessageCache
    class Base < Sinatra::Base
      set :root, File.dirname(__FILE__)
      set :sessions, true

      register Sinatra::Flash
      register Sinatra::Partial
    end
  end
end