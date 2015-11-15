class InviteGroup < ActiveRecord::Base
	belongs_to :user
	belongs_to :belong_user_to_group
	belongs_to :group
end
