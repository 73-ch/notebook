class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
    	t.string :name
    	t.integer :user_id
    	t.string :password

      	t.timestamps null: false
    end
  end
end
