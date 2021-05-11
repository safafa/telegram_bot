require_relative '../lib/bot'

describe Bot do
  let(:bot) { Bot.new("1814035314:AAEJA9-HRNunFeaI5UxGV4KBV6LUBSK8v6g") }
  let(:telegram) { bot.telegram_bot }
  describe '.initialize' do
    it 'instantiate Bot class' do
      expect(bot).to be_instance_of(Bot)
    end
    it 'initialize  a the token variable for a new bot' do
      expect(bot.token).to eq ENV['BOT_KEY']
    end
    it 'Throw error when no argument is given' do
      expect { Bot.new }.to raise_error
    end
  end

  describe '#telegram_bot' do
    it 'Throw error when  argument is given' do
      expect { bot.telegram_bot('') }.to raise_error
    end
  end
end
