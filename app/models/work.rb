class Work < ActiveRecord::Base
	has_many :notes
	has_many :note_processes
	belongs_to :user
end
