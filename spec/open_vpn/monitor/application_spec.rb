require_relative '../../spec_helper'

RSpec.describe OpenVPN::Monitor::Application do
  subject(:instance) { described_class.new }
  let(:env) { {} }

  describe '.call' do
    subject(:call) { instance.call(env) }

    it 'returns array' do
      expect(call[0]).to eq(200)
      expect(call[1]).to have_key('Content-Type')
      expect(call[2].first).to be_kind_of(String)
    end
  end
end
