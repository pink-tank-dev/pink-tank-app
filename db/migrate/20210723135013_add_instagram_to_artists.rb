class AddInstagramToArtists < ActiveRecord::Migration[6.1]
  def change
    add_column :artists, :instagram, :string
  end
end
