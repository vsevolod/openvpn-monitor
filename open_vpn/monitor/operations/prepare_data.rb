module OpenVPN
  module Monitor
    class PrepareData
      attr_reader :config

      def initialize(application)
        @config = application.config
      end

      def call
        config.sites.inject({}) do |acc, site_config|
          acc[site_config['alias']] = prepare_site(site_config)

          acc
        end
      end

      private

      def prepare_site(site_config)
        @client = OpenVPN::Management::Client.new(site_config['host'], site_config['port'])

        {
          state: @client.state,
          stats: @client.load_stats,
          sessions: @client.status
        }
      ensure
        @client.close
      end
    end
  end
end
