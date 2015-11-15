class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
    	t.string :name
    	t.integer :progress
    	t.integer :user_id
      t.string :color

      t.timestamps null: false
    end
  end
end
