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

  validates :title, :description, presence: true
end
