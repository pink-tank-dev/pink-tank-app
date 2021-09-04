class CreateSeries < ActiveRecord::Migration[6.1]
  def change
    create_table :series do |t|
      t.string :title
      t.text :description
      t.references :exhibition
      t.references :artist

      t.timestamps
    end
  end
end
