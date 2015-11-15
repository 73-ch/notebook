class CreateGroupCategories < ActiveRecord::Migration
  def change
    create_table :group_categories do |t|
      t.string :category_name
      t.integer :user_id
      t.integer :group_id
      t.string :color

      t.timestamps null: false
    end
  end
end
