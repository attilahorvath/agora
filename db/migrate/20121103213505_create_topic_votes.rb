class CreateTopicVotes < ActiveRecord::Migration
  def change
    create_table :topic_votes do |t|
      t.references :user
      t.references :topic
      t.boolean :positive
    end
    add_index :topic_votes, :user_id
    add_index :topic_votes, :topic_id
  end
end
