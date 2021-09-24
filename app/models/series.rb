# == Schema Information
#
# Table name: series
#
#  id            :bigint           not null, primary key
#  description   :text
#  title         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  artist_id     :bigint
#  exhibition_id :bigint
#
# Indexes
#
#  index_series_on_artist_id      (artist_id)
#  index_series_on_exhibition_id  (exhibition_id)
#
class Series < ApplicationRecord
  belongs_to :exhibition
  belongs_to :artist

  has_many :series_artworks
  has_many :artworks, through: :series_artworks

  validates :title, :description, presence: true
  validates :exhibition, :artist, presence: true
  validates :artworks, presence: true
  validates :artist, uniqueness: true
  validate :artworks_belong_to_series_artist

  def artworks_belong_to_series_artist
    return if artworks.empty?
    artist_ids = artworks.map(&:artist_id).compact
    unless artist_ids.length.eql?(1)
      errors.add(:base, "Series must have artwork that belongs to only 1 artist")
    end
  end
end
