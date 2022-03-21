module OpenVPN
  module Management
    module Commands
      module State
        module_function

        RAW_REGEXP = /^(>INFO|>CLIENT|END)/
        TIME = 0
        CONNECTED = 1
        SUCCESS = 2
        LOCAL_IP = 3
        REMOTE_IP = 4

        def call(content)
          raw = content.each_line.find { |l| l !~ RAW_REGEXP }.split(',')

          up_since = Time.at(raw[TIME].to_i).utc

          {
            up_since:  up_since,
            connected: raw[CONNECTED],
            success:   raw[SUCCESS],
            local_ip:  raw[LOCAL_IP],
            remote_ip: raw[REMOTE_IP],
            mode:      mode(raw)
          }
        end

        def mode(raw)
          return 'Server' if raw[REMOTE_IP] == ''

          'Client'
        end
      end
    end
  end
end
