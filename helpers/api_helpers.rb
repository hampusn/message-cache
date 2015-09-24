# API Helpers

module Hampusn
  module MessageCache
    module Helpers
      module APIHelpers

        def api_params
          @api_params ||= declared(params)
        end

      end
    end
  end
end