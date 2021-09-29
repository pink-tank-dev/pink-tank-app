class AddMediumToArtwork < ActiveRecord::Migration[6.1]
  def change
    add_column :artworks, :medium, :string
  end
end
