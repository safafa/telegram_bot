require_relative '../lib/bot'
require 'dotenv'
Dotenv.load

describe Bot do
  let(:bot) { Bot.new(ENV['BOT_KEY']) }
  let(:telegram) {bot.telegram_bot}
  describe '.initialize' do
    it 'initialize a the token variable for a new bot' do
      expect(bot).to be_instance_of(Bot)
    end
    it 'Throw error when no argument is given' do
      expect { bot.new }.to raise_error
    end
   end

   describe '#telegram_bot' do
    it 'Throw error when  argument is given' do
        expect { bot.telegram_bot("")}.to raise_error
    end
   end
end
