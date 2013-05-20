class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :user
      t.references :category
    end
    add_index :subscriptions, :user_id
    add_index :subscriptions, :category_id
  end
end
