class CreateProjecttags < ActiveRecord::Migration
  def change
    create_table :projecttags do |t|
      t.references :project, index: true, foreign_key: true
      t.references :tag, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
