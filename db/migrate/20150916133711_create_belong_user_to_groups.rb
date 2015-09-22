class CreateBelongUserToGroups < ActiveRecord::Migration
  def change
    create_table :belong_user_to_groups do |t|
    	t.integer :user_id
    	t.integer :group_id

      	t.timestamps null: false
    end
  end
end
