# == Schema Information
#
# Table name: social_media
#
#  id         :bigint           not null, primary key
#  handle     :string
#  medium     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  artist_id  :bigint
#
# Indexes
#
#  index_social_media_on_artist_id  (artist_id)
#
class SocialMedium < ApplicationRecord
  belongs_to :artist

  validates :artist, :medium, :handle, presence: true

  enum medium: %i[instagram facebook twitter]
end
