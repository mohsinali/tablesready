require 'rest_client'
class ClickatellBox
  def initialize
    @url = "https://platform.clickatell.com/messages/http/send?apiKey=#{ENV['CLICKATELL_API_ID']}"
  end

  # to could be comma seperated list
  # eg: to=923314946924,92324234234 or: to=44123122121
  def send_sms recipent,content
    begin
      url = "#{@url}&to=recipent&content=#{content}"
      response = RestClient.get(url)
      response = Hash.from_xml(response)
    rescue Exception => e
      response = {error: true, message: e.message}
    end
  end
end