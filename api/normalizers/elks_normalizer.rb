# Slack Normalizer

# 46 Elks post data:
# 
# - from:    +46704508449
# - to:      +46766861001
# - message: I want to buy 2 cartons of milk!

module Hampusn
  module MessageCache
    module API
      module Normalizers
        class ElksNormalizer
          
          def self.normalize(p)            
            p[:meta] = {
              from: p[:from],
              to:   p[:to]
            }

            p
          end

        end
      end
    end
  end
end
