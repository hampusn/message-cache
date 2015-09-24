# Slack Normalizer

# Slack post data:
# 
# - token:        XXXXXXXXXXXXXXXXXX
# - team_id:      T0001
# - team_domain:  example
# - channel_id:   C2147483705
# - channel_name: test
# - timestamp:    1355517523.000005
# - user_id:      U2147483697
# - user_name:    Steve
# - text:         googlebot: What is the air-speed velocity of an unladen swallow?
# - trigger_word: googlebot:

module Hampusn
  module MessageCache
    module API
      module Normalizers
        class SlackNormalizer
          
          def self.normalize(p)
            p[:message] = p[:text]
            
            p[:meta] = {
              team_id:      p[:team_id],
              team_domain:  p[:team_domain],
              channel_id:   p[:channel_id],
              channel_name: p[:channel_name],
              user_id:      p[:user_id],
              user_name:    p[:user_name],
              trigger_word: p[:trigger_word]
            }

            p
          end

        end
      end
    end
  end
end
