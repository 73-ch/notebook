class Note < ActiveRecord::Base
	belongs_to :category
	belongs_to :user
	belongs_to :work
	has_many :note_processes
	validates :title,
    presence: true

end
