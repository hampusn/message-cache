# User Helpers

require 'bcrypt'

module Hampusn
  module MessageCache
    module Helpers
      module UserHelpers

        def generate_new_salt
          salt = BCrypt::Engine.generate_salt
          salt
        end

        def generate_password_hash(password, salt)
          hashed_password = BCrypt::Engine.hash_secret(password, salt)
          hashed_password
        end

        def password_hash_matches?(password, salt, hashed_password)
          hashed_password == generate_password_hash(password, salt)
        end

      end
    end
  end
end