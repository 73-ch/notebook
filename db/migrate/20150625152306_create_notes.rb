class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :title
      t.text :content
      t.integer :importance
      t.integer :user_id
      t.datetime :start_time
      t.datetime :end_time
      t.boolean :alarm
      t.string :file
      t.string :site_url
      t.integer :category_id
      t.boolean :done , :default => false
      
      t.timestamps null: false
    end
  end
end
