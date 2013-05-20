class AddResetKeyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :reset_key, :string
  end
end
