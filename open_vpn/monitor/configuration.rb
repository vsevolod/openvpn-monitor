module OpenVPN
  module Monitor
    class Configuration
      attr_reader :content

      def initialize(config_path = 'config.yaml')
        @content = YAML.load_file(config_path)[:openvpn_monitor]
      end
    end
  end
end
