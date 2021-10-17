# == Schema Information
#
# Table name: artists
#
#  id              :bigint           not null, primary key
#  about           :text
#  email           :string
#  instagram       :string
#  name            :string
#  password_digest :string
#  slug            :string
#  statement       :text
#  status          :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_artists_on_slug  (slug) UNIQUE
#
class Artist < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_secure_password
  has_one_attached :avatar
  has_one :series
  has_many :posts
  has_many :social_media
  has_many :artworks

  accepts_nested_attributes_for :social_media, reject_if: :all_blank, allow_destroy: true

  validates :name, :email, :about, :statement, presence: true
  validates :status, presence: true

  enum status: %i[active inactive]

  def sito?
    id.eql?(6)
  end
end
