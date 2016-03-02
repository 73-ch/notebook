class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :category_type
      t.integer :user_id
      t.integer :progress
      t.string :color
      t.string :opp_color

      t.timestamps null: false
    end
  end
end
