require_relative '../../spec_helper.rb'

RSpec.describe OpenVPN::Management::Client do
  subject(:instance) { described_class.new(host, port) }

  let(:host) { '185.252.215.176' }
  let(:port) { 5550 }

  describe '.pid' do
    subject(:method) { instance.pid }

    let(:result) { 'pid=1' }

    it 'returns success', cassette: 'management/pid' do
      expect(method).to eq(result)
    end
  end

  describe '.state' do
    subject(:method) { instance.state }

    let(:result) do
      {
        up_since: Time.at(1647894385).utc,
        connected: 'CONNECTED',
        success: 'SUCCESS',
        local_ip: '192.168.255.1',
        remote_ip: '',
        mode: 'Server'
      }
    end

    it 'returns success', cassette: 'management/state' do
      expect(method).to eq(result)
    end
  end

  describe '.load_stats' do
    subject(:method) { instance.load_stats }

    let(:result) do
      {
        nclients: '1',
        bytesin: '5088181',
        bytesout:'307029090'
      }
    end

    it 'returns success', cassette: 'management/load_stats' do
      expect(method).to eq(result)
    end
  end

  describe '.status' do
    subject(:method) { instance.status }

    let(:result) do
      'status'
    end

    it 'returns success', cassette: 'management/status' do
      expect(method.dig(:clients, 0)).to eq(
        client_id: "0",
        connected_since: "Mon Mar 21 20:27:06 2022",
        ipv6_address: "",
        name: "seva",
        peer_id: "0",
        real_address: "5.16.114.65:4581",
        received_bytes: "5088222",
        sent_bytes: "307029172",
        username: "UNDEF",
        virtual_address: "192.168.255.6"
      )

      expect(method.dig(:tables, 0)).to eq(
        last_ref: "Mon Mar 21 22:49:10 2022",
        name: "seva",
        real_address: "5.16.114.65:4581",
        virtual_address: "192.168.255.6"
      )
    end
  end

  describe 'version' do
    subject(:method) { instance.version }

    let(:result) do
      <<~TEXT
       >INFO:OpenVPN Management Interface Version 1 -- type 'help' for more info
       OpenVPN Version: OpenVPN 2.4.9 x86_64-alpine-linux-musl [SSL (OpenSSL)] [LZO] [LZ4] [EPOLL] [MH/PKTINFO] [AEAD] built on Apr 20 2020
       Management Version: 1
       END
      TEXT
    end

    it 'returns success', cassette: 'management/version' do
      expect(method).to eq(result)
    end
  end
end
