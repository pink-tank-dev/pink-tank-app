class CreateSocialMedia < ActiveRecord::Migration[6.1]
  def change
    create_table :social_media do |t|
      t.integer :medium
      t.string :handle
      t.references :artist

      t.timestamps
    end
  end
end
