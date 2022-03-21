module OpenVPN
  module Management
    module Commands
      def pid
        send('pid')
      end

      def version
        send('version')
      end

      def state
        State.call(send('state'))
      end

      def load_stats
        raw = send('load-stats').scan(/=([^,]*)(?:,|$)/)

        {
          nclients: raw[0].first,
          bytesin: raw[1].first,
          bytesout: raw[2].first
        }
      end

      def status
        Status.call(send('status 2'))
      end
    end
  end
end
