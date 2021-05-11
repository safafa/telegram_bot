require 'dotenv'
require_relative '../lib/bot'
Dotenv.load
bot = Bot.new(ENV['BOT_KEY'])
bot.telegram_bot
