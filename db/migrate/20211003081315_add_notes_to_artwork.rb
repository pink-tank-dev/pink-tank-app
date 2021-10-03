class AddNotesToArtwork < ActiveRecord::Migration[6.1]
  def change
    add_column :artworks, :notes, :text
  end
end
