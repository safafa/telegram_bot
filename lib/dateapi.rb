require 'uri'
require 'net/http'
require 'openssl'
require 'json'

class DateApi
  attr_reader :day, :month, :api_err

  def initialize(month, day)
    @month = month
    @day = day
    @api_err = ''
  end

  def message
    url = URI("https://numbersapi.p.rapidapi.com/#{@month}/#{@day}/date?json=true&fragment=true")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request['x-rapidapi-key'] = '5ab8b06151msh2a2292ff926d71cp1cf742jsn4ef5742bf2ab'
    request['x-rapidapi-host'] = 'numbersapi.p.rapidapi.com'
    begin
      response = http.request(request)
    rescue Timeout
      @api_err = 'API errors request has been sent again'
      retry
    else
      JSON.parse(response.read_body)
    end
  end
end
