# Generic Normalizer

module Hampusn
  module MessageCache
    module API
      module Normalizers
        class GenericNormalizer
          
          def self.normalize(p)
            # Generic normalizer doesn't do anything,
            # we just hope for the best.
            p
          end

        end
      end
    end
  end
end
