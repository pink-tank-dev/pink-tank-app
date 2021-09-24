# == Schema Information
#
# Table name: series_artworks
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  artwork_id :bigint           not null
#  series_id  :bigint           not null
#
# Indexes
#
#  index_series_artworks_on_artwork_id  (artwork_id)
#  index_series_artworks_on_series_id   (series_id)
#
# Foreign Keys
#
#  fk_rails_...  (artwork_id => artworks.id)
#  fk_rails_...  (series_id => series.id)
#
class SeriesArtwork < ApplicationRecord
  belongs_to :series
  belongs_to :artwork
end
