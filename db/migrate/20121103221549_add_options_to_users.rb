class AddOptionsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :comment_notification, :boolean, :default => false
    add_column :users, :reply_notification, :boolean, :default => false
  end
end
