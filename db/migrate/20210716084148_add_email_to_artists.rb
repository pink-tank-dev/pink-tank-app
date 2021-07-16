class AddEmailToArtists < ActiveRecord::Migration[6.1]
  def change
    add_column :artists, :email, :string
  end
end
