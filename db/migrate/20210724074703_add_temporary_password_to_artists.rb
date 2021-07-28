class AddTemporaryPasswordToArtists < ActiveRecord::Migration[6.1]
  def change
    add_column :artists, :temporary_password, :string
  end
end
