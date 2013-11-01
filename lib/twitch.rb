class Twitch
  attr_accessor :username
  def initialize(username)
    @username = username
  end

  def get_stream
    HTTParty.get("https://api.twitch.tv/kraken/streams/#{@username}") if @username.present?
  end

  def stream_live?
    HTTParty.get("https://api.twitch.tv/kraken/streams/#{@username}")["stream"] if @username.present?
  end

  def get_stream_url
    get_stream["stream"]["channel"]["url"]
  end

  def get_channel_url
    HTTParty.get("https://api.twitch.tv/kraken/channels/#{@username}")["url"]
  end
end
