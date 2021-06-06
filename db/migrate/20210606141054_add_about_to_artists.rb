class AddAboutToArtists < ActiveRecord::Migration[6.1]
  def change
    add_column :artists, :about, :text
  end
end
