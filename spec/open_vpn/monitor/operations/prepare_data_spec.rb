require_relative '../../../spec_helper'

RSpec.describe OpenVPN::Monitor::PrepareData do
  subject(:instance) { described_class.new(app) }
  let(:app) { OpenVPN::Monitor::Application.new }

  describe '.call', cassette: 'monitor/prepare_data' do
    subject(:method) { instance.call('UDP') }

    it 'succesfully returns data' do
      expect { method }.not_to raise_error

      expect(method[:sites]).to eq(['UDP'])
      expect(method).to have_key(:state)
      expect(method).to have_key(:stats)
      expect(method).to have_key(:sessions)
      expect(method[:sessions]).to have_key(:clients)
      expect(method[:sessions]).to have_key(:tables)
    end
  end
end
