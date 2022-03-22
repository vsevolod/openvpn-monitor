module OpenVPN
  module Monitor
    class GenerateHTML
      include Helper

      INDEX_ERB = 'open_vpn/monitor/views/index.html.erb'

      attr_reader :config

      def initialize(application)
        @config = application.config
      end

      # {
      #   sites: [...],
      #   state: @client.state,
      #   stats: @client.load_stats,
      #   sessions: @client.status
      # }
      def call(data)
        index = ERB.new(File.read(INDEX_ERB))
        index.result(binding)
      end
    end
  end
end
