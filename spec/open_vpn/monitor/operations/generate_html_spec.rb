require_relative '../../../spec_helper'

RSpec.describe OpenVPN::Monitor::GenerateHTML do
  subject(:instance) { described_class.new(app) }
  let(:app) { OpenVPN::Monitor::Application.new }

  describe '.call' do #, cassette: 'monitor/generate_html' do
    subject(:method) { instance.call(data) }
    let(:data) do
      {
        sites: ['UDP'],
        current_site: 'UDP',
        state: {
          up_since: Time.now.utc,
          connected: "CONNECTED",
          success: "SUCCESS",
          local_ip: "192.168.255.1",
          remote_ip: "",
          mode: "Server"
        },
        stats: {
          nclients: "1",
          bytesin: "5084573",
          bytesout: "307025277"
        },
        sessions: {
          clients: [{
            name: "seva",
            real_address: "5.16.114.65:4581",
            virtual_address: "192.168.255.6",
            ipv6_address: "",
            received_bytes: "5084573",
            sent_bytes: "307025277",
            connected_since: "Mon Mar 21 20:27:06 2022",
            username: "UNDEF",
            client_id: "0",
            peer_id: "0"
          }],
          tables: [{
            virtual_address: "192.168.255.6",
            name: "seva",
            real_address: "5.16.114.65:4581",
            last_ref: "Mon Mar 21 22:49:10 2022"
          }]
        }
      }
    end

    it 'succesfully returns html' do
      expect { method }.not_to raise_error
    end
  end
end
