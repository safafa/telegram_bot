require 'telegram/bot'
require_relative 'dateapi'

class Bot
  attr_reader :token
  def initialize(token)
    @token = token
  end

  def telegram_bot
    Telegram::Bot::Client.run(@token) do |bot|
      chat(bot)
    end
  end

  private

  def chat(bot)
    bot.listen do |message|
      cases(bot, message)
    end
  end

  def cases(bot, message)
    case message.text
    when '/start'
      how_are_you('Hello, How are you?', bot, message)
    when 'Hello'
      how_are_you('Hey, How are you?', bot, message)
    when 'Fine'
      polite("That's good to hear", bot, message)
    when 'Good'
      polite('Me too', bot, message)
    when "I'm Ok"
      polite('Okey dokey!', bot, message)
    when "I'm alive"
      polite('Oh lucky you! I wish I was alive', bot, message)
    when '/Today'
      today_date(bot, message)
    when '/Random'
      random_date(bot, message)
    when '/stop'
      stop(bot, message)
    else
      else_when(bot, message)
    end
  end

  def how_are_you(question, bot, message)
    answers =
      Telegram::Bot::Types::ReplyKeyboardMarkup
        .new(keyboard: [%w[Fine Good], ["I'm alive", "I'm Ok"]], one_time_keyboard: true)
    bot.api.send_message(chat_id: message.chat.id, text: question, reply_markup: answers)
  end

  def polite(msg, bot, message)
    bot.api.send_message(chat_id: message.chat.id, text: msg)
    question = "Select a Date you're curious about to get started: /Today or /Random "
    bot.api.send_message(chat_id: message.chat.id, text: question)
  end

  def random_date(bot, message)
    time = Time.at(rand * Time.now.to_i)
    day = time.day.to_s
    month = time.month.to_s
    response = DateApi.new(month, day)
    msg = response.message
    bot.api.send_message(chat_id: message.chat.id,
                         text: "#{day}-#{month}-#{msg['year']},  #{msg['text']}")
  end

  def today_date(bot, message)
    time = Time.now
    day = time.day.to_s
    month = time.month.to_s
    response = DateApi.new(month, day)
    msg = response.message
    bot.api.send_message(chat_id: message.chat.id,
                         text: "#{day}-#{month}-#{msg['year']},  #{msg['text']}")
  end

  def stop(bot, message)
    bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}",
                         date: message.date)
  end

  def else_when(bot, message)
    bot.api.send_message(chat_id: message.chat.id,
                         text: "#{message.from.first_name},try /start,  /stop , /Today or /Random")
  end
end
