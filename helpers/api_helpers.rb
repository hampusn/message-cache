# API Helpers

module Hampusn
  module MessageCache
    module Helpers
      module APIHelpers

        def api_params
          @api_params ||= declared(params)
        end

        def class_exists?(class_name)
          c = Module.const_get(class_name)
          return c.is_a?(Class)
        rescue NameError
          return false
        end

        def get_normalizer(normalizer_name)
          normalizer = Hampusn::MessageCache::API::Normalizers::GenericNormalizer

          # Bail early if normalizer_name is not in the "whitelist" array.
          return normalizer unless ['elks', 'slack'].include? normalizer_name

          normalizer_name = "Hampusn::MessageCache::API::Normalizers::" + normalizer_name.capitalize + 'Normalizer'

          if class_exists? normalizer_name
            normalizer = Object.const_get normalizer_name
          end

          normalizer
        end

      end
    end
  end
end