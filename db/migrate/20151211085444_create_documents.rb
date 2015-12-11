class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.integer :user_id
      t.integer :friend_id
      t.text :text

      t.timestamps null: false
    end
  end
end
