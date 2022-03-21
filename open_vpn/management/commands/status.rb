module OpenVPN
  module Management
    module Commands
      module Status
        module_function

        CLIENT_LIST = /^CLIENT_LIST,(.+)/
        ROUTING_TABLE = /^ROUTING_TABLE,(.+)/

        def call(content)
          content.each_line.inject({clients: [], tables: []}) do |acc, line|
            case line
            when CLIENT_LIST
              acc[:clients] << client_list(Regexp.last_match(1))
            when ROUTING_TABLE
              acc[:tables] << routing_table(Regexp.last_match(1))
            end

            acc
          end
        end

        def client_list(line)
          raw = line.split(',')

          {
            name: raw[0],
            real_address: raw[1],
            virtual_address: raw[2],
            ipv6_address: raw[3],
            received_bytes: raw[4],
            sent_bytes: raw[5],
            connected_since: raw[6],
            username: raw[8],
            client_id: raw[9],
            peer_id: raw[10]
          }
        end

        def routing_table(line)
          raw = line.split(',')

          {
            virtual_address: raw[0],
            name: raw[1],
            real_address: raw[2],
            last_ref: raw[3]
          }
        end
      end
    end
  end
end
