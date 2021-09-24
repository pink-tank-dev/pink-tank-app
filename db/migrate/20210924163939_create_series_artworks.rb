class CreateSeriesArtworks < ActiveRecord::Migration[6.1]
  def change
    create_table :series_artworks do |t|
      t.references :series, null: false, foreign_key: true
      t.references :artwork, null: false, foreign_key: true

      t.timestamps
    end
  end
end
