class NoteProcess < ActiveRecord::Base
	belongs_to :note
	belongs_to :user
	belongs_to :work
end
