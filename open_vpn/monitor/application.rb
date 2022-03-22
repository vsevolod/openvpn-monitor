module OpenVPN
  module Monitor
    class Application
      attr_reader :config

      def initialize
        @config = Configuration.new
      end

      def call(env)
        current_site = site(env)
        return error_404 if current_site.nil?

        data = OpenVPN::Monitor::PrepareData.new(self).call(current_site)
        html = OpenVPN::Monitor::GenerateHTML.new(self).call(data)

        [200, headers, [html]]
      end

      private

      def site(env)
        name = env.fetch('PATH_INFO', '').sub(/^\//, '')
        return config.sites.first['alias'] if name == ''

        config.sites.find { _1['alias'] == name }
      end

      def headers
        { 'Content-Type' => 'text/html' }
      end

      def error_404
        [404, headers, ['404 Page not found']]
      end
    end
  end
end
