class AddTemporaryPasswordToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :temporary_password, :string
  end
end
