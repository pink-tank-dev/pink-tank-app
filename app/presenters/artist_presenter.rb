class ArtistPresenter < SimpleDelegator
  def self.from_list(*artists)
    artists.flatten.map { |artist| ArtistPresenter.new(artist) }
  end

  def initialize(artist)
    super(artist)
  end

  def badge_type
    active? ? "success" : "warning"
  end
end
