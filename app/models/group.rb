class Group < ActiveRecord::Base
	has_many :users
	has_many :belong_user_to_groups
	has_many :invite_groups
	has_many :group_notes
	has_many :group_categories
end
