class Note < ActiveRecord::Base
	belongs_to :category
	belongs_to :user
	belongs_to :group
	validates :title,
    presence: true

end
