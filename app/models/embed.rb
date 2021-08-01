class Embed
  include ActiveModel::Model
  include ActiveModel::Attributes
  include GlobalID::Identification
  include ActionText::Attachable
  YT_EMBED = "youtube.com/embed".freeze
  YT_WATCH = "youtube.com/watch".freeze
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
    else
      id
    end
  end
end
