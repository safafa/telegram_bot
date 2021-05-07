require 'telegram/bot'
require_relative 'dateapi'


class Bot 
    def initialize 
        @@token = '1814035314:AAEJA9-HRNunFeaI5UxGV4KBV6LUBSK8v6g'
        Telegram::Bot::Client.run(@@token) do |bot|
            bot.listen do |message|
              case message.text
                when '/start'
                    bot.api.send_message(chat_id: message.chat.id, text: "Hello #{message.from.first_name}, How are you?")
                
                when 'Fine'
                    bot.api.send_message(chat_id: message.chat.id, text: "That's good to hear")
                    bot.api.send_message(chat_id: message.chat.id, text: "Send Date you're curious about to get started")
                when 'Date'
                    response = DateApi.new("7","16")
                    msg = response.message
                    bot.api.send_message(chat_id: message.chat.id, text: "Same day year #{msg["year"]}, #{msg["text"]}")
                end
            end
          end
    end
end