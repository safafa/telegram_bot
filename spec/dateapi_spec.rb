require_relative '../lib/dateapi'
require 'dotenv'
Dotenv.load

describe DateApi do
  let(:dateapi) { DateApi.new('06', '01') }
  describe '.initialize' do
    it 'instantiate dateapi class' do
      expect(dateapi).to be_instance_of(DateApi)
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
