require_relative '../../spec_helper.rb'

RSpec.describe OpenVPN::Management::Client do
  subject(:instance) { described_class.new(host, port) }

  let(:host) { '185.252.215.176' }
  let(:port) { 5550 }

  describe 'pid' do
    subject(:method) { instance.pid }

    let(:result) do
      <<~TEXT
        >INFO:OpenVPN Management Interface Version 1 -- type 'help' for more info
        SUCCESS: pid=1
      TEXT
    end

    it 'returns success', cassette: 'management/pid' do
      expect(method).to eq(result)
    end
  end
end
