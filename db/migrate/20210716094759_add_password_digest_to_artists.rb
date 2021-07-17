class AddPasswordDigestToArtists < ActiveRecord::Migration[6.1]
  def change
    add_column :artists, :password_digest, :string
  end
end
