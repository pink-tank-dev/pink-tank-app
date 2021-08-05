class Embed
  include ActiveModel::Model
  include ActiveModel::Attributes
  include GlobalID::Identification
  include ActionText::Attachable
  YT_EMBED = "youtube.com/embed".freeze
  YT_WATCH = "youtube.com/watch".freeze
  SPOTIFY_TRACK = "spotify.com/track".freeze
  SPOTIFY_ALBUM = "spotify.com/album".freeze
  SPOTIFY_PLAYLIST = "spotify.com/playlist".freeze
  VIMEO = "vimeo.com".freeze

  attribute :id

  def self.find(id)
    new(id: id)
  end

  def source
    case
    when id.include?(YT_EMBED)
      id
    when id.include?(YT_WATCH)
      params = Rack::Utils.parse_query(URI(id).query)
      "https://www.youtube.com/embed/#{params["v"]}"
    when id.include?(VIMEO)
      param = id.split('/').last
      "https://player.vimeo.com/video/#{param}"
    when id.include?(SPOTIFY_TRACK)
      param = URI(id).path.split('/').last
      "https://open.spotify.com/embed/track/#{param}"
    when id.include?(SPOTIFY_ALBUM)
      param = URI(id).path.split('/').last
      "https://open.spotify.com/embed/album/#{param}"
    when id.include?(SPOTIFY_PLAYLIST)
      param = URI(id).path.split('/').last
      "https://open.spotify.com/embed/playlist/#{param}"
    else
      id
    end
  end
end
