class RemoveTemporaryPasswordFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :temporary_password, :string
  end
end
