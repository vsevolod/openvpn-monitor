module OpenVPN
  module Management
    module Commands
      class Status
        attr_reader :client

        def initialize(client)
          @client = client
        end

        def call
        end
      end
    end
  end
end
