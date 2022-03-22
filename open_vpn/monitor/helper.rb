module OpenVPN
  module Monitor
    module Helper
      def number_format(num)
        n2, n3 = num.to_i, 0

        while n2 >= 1e3
           n2 /= 1e3
           n3 += 1
        end

        '%.3f' % n2 + ['', ' KB', ' MB', ' GB'][n3]
      end
    end
  end
end
