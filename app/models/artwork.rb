# == Schema Information
#
# Table name: artworks
#
#  id          :bigint           not null, primary key
#  description :text
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  artist_id   :bigint
#
# Indexes
#
#  index_artworks_on_artist_id  (artist_id)
#
class Artwork < ApplicationRecord
  belongs_to :artist

  has_one_attached :file

  validates :file, :title, :description, presence: true
end
