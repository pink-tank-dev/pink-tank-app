class RemoveTemporaryPasswordFromArtists < ActiveRecord::Migration[6.1]
  def change
    remove_column :artists, :temporary_password, :string
  end
end
