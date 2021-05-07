require 'telegram/bot'
require_relative 'dateapi'


class Bot 
    def initialize(token)
        @@token = token
        Telegram::Bot::Client.run(@@token) do |bot|
            bot.listen do |message|
              case message.text
                when '/start' 
                    question = 'Hey, How are you?'
                    answers =
                      Telegram::Bot::Types::ReplyKeyboardMarkup
                      .new(keyboard: [%w(Fine Good), ["I'm alive", "I'm Ok"]], one_time_keyboard: true)
                    bot.api.send_message(chat_id: message.chat.id, text: question, reply_markup: answers)
                when 'Hello' 
                    question = 'Hey, How are you?'
                    answers =
                      Telegram::Bot::Types::ReplyKeyboardMarkup
                      .new(keyboard: [%w(Fine Good), ["I'm alive", "I'm Ok"]], one_time_keyboard: true)
                    bot.api.send_message(chat_id: message.chat.id, text: question, reply_markup: answers)
                when 'Fine'
                    bot.api.send_message(chat_id: message.chat.id, text: "That's good to hear")
                    question = "Select a Date you're curious about to get started: /Today or /Random "
                    bot.api.send_message(chat_id: message.chat.id, text: question)
                when 'Good'
                    bot.api.send_message(chat_id: message.chat.id, text: "Me too")
                    question = "Select a Date you're curious about to get started: /Today or /Random "
                    bot.api.send_message(chat_id: message.chat.id, text: question)
                when "I'm Ok"
                    bot.api.send_message(chat_id: message.chat.id, text: "Okey dokey!")
                    question = "Select a Date you're curious about to get started: /Today or /Random "
                    bot.api.send_message(chat_id: message.chat.id, text: question)
                when "I'm alive"
                    bot.api.send_message(chat_id: message.chat.id, text: "Oh lucky you! I wish I was alive")
                    question = "Select a Date you're curious about to get started: /Today or /Random "
                    bot.api.send_message(chat_id: message.chat.id, text: question)
                when '/Today'
                    time = Time.now
                    day = time.day.to_s
                    month = time.month.to_s
                    response = DateApi.new(day, month)
                    msg = response.message
                    bot.api.send_message(chat_id: message.chat.id, text: "#{day}-#{month}-#{msg["year"]},  #{msg["text"]}")
                when '/Random'
                    time = Time.at(rand * Time.now.to_i)
                    day = time.day.to_s
                    month = time.month.to_s
                    response = DateApi.new(day, month)
                    msg = response.message
                    bot.api.send_message(chat_id: message.chat.id, text: "#{day}-#{month}-#{msg["year"]},  #{msg["text"]}")
                when '/stop'
                    bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}", date: message.date)
                else bot.api.send_message(chat_id: message.chat.id, text: "Invalid entry, #{message.from.first_name}, Here is the list of commands you can send  /start,  /stop , /Today or /Random")
                end
            end
          end
    end
end