require_relative '../lib/dateapi'

describe DateApi do
  let(:dateapi) { DateApi.new('06', '01') }
  describe '.initialize' do
    it 'instantiate dateapi class' do
      expect(dateapi).to be_instance_of(DateApi)
    end
    it 'initialize  a the day  variable ' do
      expect(dateapi.day).to eq '01'
    end
    it 'initialize  a the month variable ' do
      expect(dateapi.month).to eq '06'
    end
    it 'Throw error when no argument is given' do
      expect { DateApi.new }.to raise_error
    end
  end

  describe '#message' do
    it 'return a Hash object' do
      expect(dateapi.message).to be_instance_of(Hash)
    end
  end
end
