class AddPriceCentsToArtwork < ActiveRecord::Migration[6.1]
  def change
    add_column :artworks, :price_cents, :integer, null: false, default: 0
  end
end
