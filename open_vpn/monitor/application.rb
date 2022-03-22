module OpenVPN
  module Monitor
    class Application
      attr_reader :config

      def initialize
        @config = Configuration.new
      end

      def call(_env)
        data = OpenVPN::Monitor::PrepareData.new(self).call

        [200, headers, ['OK']]
      end

      private

      def headers
        {
          'Content-Type' => 'text/html'
        }
      end
    end
  end
end
