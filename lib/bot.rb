require 'telegram/bot'



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
                    bot.api.send_message(chat_id: message.chat.id, text: "Send Date to get started")
                when 'Date'
                    bot.api.send_message(chat_id: message.chat.id, text: "Now tell me what date are you curious about?")
                end
            end
          end
    end
end