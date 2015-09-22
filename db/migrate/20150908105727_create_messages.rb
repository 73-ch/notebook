class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :title
      t.text :content
      t.integer :importance
      t.integer :user_id
      t.integer :for_user
      t.datetime :start_time
      t.datetime :end_time
      t.integer :message_type
      t.string :site_urls
      t.boolean :done , :default => false
      
      t.timestamps null: false
    end
  end
end
