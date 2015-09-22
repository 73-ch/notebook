class BelongUserToGroupController < ApplicationController
	def index
		@belong_user_to_groups = BelongUserToGroup.where(user_id: session[:user_id])
	end
	def new
		@belong_user_to_group = BelongUserToGroup.new
		@groups = Group.all
	end
	def create
		@belong_user_to_group = BelongUserToGroup.create(belong_user_to_group_params)
		@belong_user_to_group.user_id = session[:user_id]
		@belong_user_to_group.save
	end
	def destroy
		@belong_user_to_group = BelongUserToGroup.find(parmas[:id])
		@belong_user_to_group.destroy
		redtrect_to index
	end
	private
	def belong_user_to_group_params
		params.require(:belong_user_to_group).permit(:group_id)
	end
end
