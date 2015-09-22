class Group < ActiveRecord::Base
	has_many :users
	has_many :belong_user_to_groups
	has_many :notes
end
