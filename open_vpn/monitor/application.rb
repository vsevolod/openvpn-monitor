module OpenVPN
  module Monitor
    class Application
      attr_reader :config

      def initialize
        @config = Configuration.new
      end

      def call(env)
        data = OpenVPN::Monitor::PrepareData.new(self).call(site(env))
        html = OpenVPN::Monitor::GenerateHTML.new(self).call(data)

        [200, headers, [html]]
      end

      private

      def site(env)
        name = env.fetch('PATH_INFO', '').sub(/^\//, '')
        name = config.sites.first['alias'] if name == ''
        name
      end

      def headers
        {
          'Content-Type' => 'text/html'
        }
      end
    end
  end
end
