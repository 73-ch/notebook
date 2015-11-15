class GroupNote < ActiveRecord::Base
	belongs_to :group
	belongs_to :user
	belongs_to :group_dategories
end
