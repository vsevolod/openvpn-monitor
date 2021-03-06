# TODO:
#   Add password?

module OpenVPN
  module Management
    class Client
      include Commands

      CommandError = Class.new(StandardError)

      TIMEOUT = 10
      COMMAND_MATCHER = /(SUCCESS:.*\n|ERROR:.*\n|END.*\n)/
      ERROR = /^ERROR\: (.+)$/
      SUCCESS = /^SUCCESS\: (.+)$/
      PROMPT_MATCHER = />INFO:OpenVPN.*$/

      attr_reader :sock

      def initialize(host, port)
        telnet_options = {
          'Host' => host,
          'Port' => port,
          'Timeout' => TIMEOUT,
          'Prompt' => PROMPT_MATCHER
        }

        @sock = Net::Telnet::new(telnet_options)
      end

      def close
        @sock.close
      end

      def send(command)
        result = @sock.cmd("String" => command, "Match" => COMMAND_MATCHER)

        case result
        when SUCCESS
          Regexp.last_match(1)
        when ERROR
          raise CommandError, Regexp.last_match(1)
        else
          result
        end
      end
    end
  end
end
