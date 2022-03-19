module OpenVPN
  module Management
    module Commands
      def pid
        send('pid')
      end
    end
  end
end
