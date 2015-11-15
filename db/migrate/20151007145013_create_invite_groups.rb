class CreateInviteGroups < ActiveRecord::Migration
  def change
    create_table :invite_groups do |t|
    	t.integer :invite_user
    	t.integer :invited_user
    	t.integer :group_id

      	t.timestamps null: false
    end
  end
end
