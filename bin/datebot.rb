require_relative '../lib/bot'
require 'dotenv'
Dotenv.load
bot = Bot.new(ENV['BOT_KEY'])
bot.chat
