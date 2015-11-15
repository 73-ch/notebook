class GroupCategory < ActiveRecord::Base
	has_many :group_notes
	belongs_to :group
	belongs_to :user
end
