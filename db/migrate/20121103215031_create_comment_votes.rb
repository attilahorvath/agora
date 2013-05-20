class CreateCommentVotes < ActiveRecord::Migration
  def change
    create_table :comment_votes do |t|
      t.references :user
      t.references :comment
      t.boolean :positive
    end
    add_index :comment_votes, :user_id
    add_index :comment_votes, :comment_id
  end
end
