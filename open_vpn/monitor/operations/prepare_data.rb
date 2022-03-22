module OpenVPN
  module Monitor
    class PrepareData
      attr_reader :config

      def initialize(application)
        @config = application.config
      end

      def call(current_site)
        site_config = config.sites.find{ _1['alias'] == current_site }

        {
          sites: config.sites.map { _1['alias'] },
          current_site: current_site,
          **prepare_site(site_config)
        }
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
