class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.integer :user_id
      t.integer :friend_id
      t.boolean :approved, :null => false, :default => false

      t.timestamps null: false
    end
  end
end
