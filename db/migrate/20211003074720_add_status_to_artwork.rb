class AddStatusToArtwork < ActiveRecord::Migration[6.1]
  def change
    add_column :artworks, :status, :integer
  end
end
