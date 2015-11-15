class CreateGroupNotes < ActiveRecord::Migration
  def change
    create_table :group_notes do |t|
      t.string :title
      t.text :content
      t.integer :importance
      t.integer :user_id
      t.datetime :start_time
      t.datetime :end_time
      t.integer :note_type
      t.string :site_url
      t.integer :category_id
      t.integer :group_id
      t.boolean :done , :default => false
      t.integer :progress, :default => 0

      t.timestamps null: false
    end
  end
end
