require 'sinatra/base'

module Hampusn
  module MessageCache
    class Base < Sinatra::Base
      set :root, File.dirname(__FILE__)
    end
  end
end