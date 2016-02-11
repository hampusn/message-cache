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
              if status >= 200 && status < 300
                status = query_params["success_code"]
              end
            end

            [status, headers, response]
          end

        end
      end
    end
  end
end