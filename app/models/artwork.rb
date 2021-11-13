# == Schema Information
#
# Table name: artworks
#
#  id           :bigint           not null, primary key
#  description  :text
#  measurements :string
#  medium       :string
#  notes        :text
#  position     :integer
#  price_cents  :integer          default(0), not null
#  status       :integer
#  title        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  artist_id    :bigint
#
# Indexes
#
#  index_artworks_on_artist_id  (artist_id)
#
class Artwork < ApplicationRecord
  acts_as_list

  belongs_to :artist

  has_one_attached :file

  validates :title, :description, presence: true
  validates :medium, :measurements, :status, presence: true

  enum status: %i[available sold]

  monetize :price_cents

  scope :by_artist, -> (id) { where(artist_id: id) }
end
