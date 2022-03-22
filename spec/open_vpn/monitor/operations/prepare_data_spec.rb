require_relative '../../../spec_helper'

RSpec.describe OpenVPN::Monitor::PrepareData do
  subject(:instance) { described_class.new(app) }
  let(:app) { OpenVPN::Monitor::Application.new }

  describe '.call', cassette: 'monitor/prepare_data' do
    subject(:method) { instance.call }

    it 'succesfully returns data' do
      expect { method }.not_to raise_error
      site_data = method['UDP']

      expect(site_data).to have_key(:state)
      expect(site_data).to have_key(:stats)
      expect(site_data).to have_key(:sessions)
      expect(site_data[:sessions]).to have_key(:clients)
      expect(site_data[:sessions]).to have_key(:tables)
    end
  end
end
