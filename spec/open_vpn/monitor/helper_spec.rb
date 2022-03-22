require_relative '../../spec_helper'

RSpec.describe OpenVPN::Monitor::Helper do
  class DummyClass
    include OpenVPN::Monitor::Helper
  end

  subject(:instance) { DummyClass.new }

  describe '.number_format' do
    subject(:number_format) { instance.number_format(num) }

    context 'when megabytes' do
      let(:num) { '5084573' }

      it 'returns formatted string' do
        expect(number_format).to eq('5.085 MB')
      end
    end

    context 'when kylobytes' do
      let(:num) { '53873' }

      it 'returns formatted string' do
        expect(number_format).to eq('53.873 KB')
      end
    end

    context 'when gigabytes' do
      let(:num) { '12345678901' }

      it 'returns formatted string' do
        expect(number_format).to eq('12.346 GB')
      end
    end
  end
end
