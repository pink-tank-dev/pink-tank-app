class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :status, null: false, default: 0
      t.string :title
      t.references :artist

      t.timestamps
    end
  end
end
