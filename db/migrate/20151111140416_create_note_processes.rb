class CreateNoteProcesses < ActiveRecord::Migration
  def change
    create_table :note_processes do |t|
    	t.string :title
    	t.integer :note_id
    	t.integer :user_id
    	t.boolean :completed, :default => false

      t.timestamps null: false
    end
  end
end
