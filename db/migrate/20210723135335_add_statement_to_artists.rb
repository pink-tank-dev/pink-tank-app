class AddStatementToArtists < ActiveRecord::Migration[6.1]
  def change
    add_column :artists, :statement, :text
  end
end
