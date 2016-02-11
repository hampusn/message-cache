# CustomStatusCode Middleware
require 'rack'

module Hampusn
  module MessageCache
    module API
      module Middlewares
        class CustomStatusCodeMiddleware < Grape::Middleware::Base

          def initialize(app)
            @app = app
          end

          def call(env)
            status, headers, response = @app.call(env)

            query_params = Rack::Utils.parse_nested_query(env["QUERY_STRING"])
            # env["api.endpoint"]

            if query_params.has_key? "success_code"
              success_code          = query_params["success_code"].to_i
              success_code_is_valid = success_code >= 100 && success_code < 600
              status_is_success     = status >= 200 && status < 300

              if success_code_is_valid && status_is_success
                status = success_code
              end
            end

            [status, headers, response]
          end

        end
      end
    end
  end
end