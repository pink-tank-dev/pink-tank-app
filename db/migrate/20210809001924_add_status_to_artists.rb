class AddStatusToArtists < ActiveRecord::Migration[6.1]
  def change
    add_column :artists, :status, :integer
  end
end
