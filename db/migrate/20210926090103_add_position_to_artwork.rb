class AddPositionToArtwork < ActiveRecord::Migration[6.1]
  def change
    add_column :artworks, :position, :integer
  end
end
