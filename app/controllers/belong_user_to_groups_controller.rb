class BelongUserToGroupsController < ApplicationController
	before_action :check , only: [:create]
	before_action :login_checker
	def index
		@belong_user_to_groups = BelongUserToGroup.where(user_id: session[:user_id])
	end
	def new
		@belong_user_to_group = BelongUserToGroup.new
		@groups = Group.all
	end
	def create
		@group = Group.where(id: params[:group_id])
		@belong_user_to_group = BelongUserToGroup.create(belong_user_to_group_params)
		invite = InviteGroup.find_by(invited_user: session[:user_id], group_id: params[:belong_user_to_group][:group_id])
		logger.info("a: #{invite}")
		invite.destroy
		invite.save
	end
	def destroy
		@belong_user_to_group = BelongUserToGroup.find(parmas[:id])
		@belong_user_to_group.destroy
		redirect_to "/index"
	end
	private
	def belong_user_to_group_params
		params.require(:belong_user_to_group).permit(:group_id,:user_id)
	end
	def check
		belong = BelongUserToGroup.where(group_id: params[:belong_user_to_group][:group_id], user_id: params[:belong_user_to_group][:user_id]).count
		if belong != 0
			redirect_to "/index"
		end
	end
end
