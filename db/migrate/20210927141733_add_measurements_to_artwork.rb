class AddMeasurementsToArtwork < ActiveRecord::Migration[6.1]
  def change
    add_column :artworks, :measurements, :string
  end
end
