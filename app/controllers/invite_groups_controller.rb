class InviteGroupsController < ApplicationController
	before_action :check , only: :create
	def new
		@invite_group = InviteGroup.new
		belongs = BelongUserToGroup.where(user_id: session[:user_id])
		group_ides = []
		belongs.each do |belong|
			group_id = belong.group_id
			group_ides.push(group_id)
		end
		@groups = Group.where(id: group_ides)
		users = []
    	@follows = Follow.where(user_id: session[:user_id])
    	@follows.each do |follow|
      		followed_id = follow.followed_id
      		follow_check = Follow.where(user_id: followed_id, followed_id: session[:user_id]).present?
      		if follow_check == true
          		users.push(followed_id)
      		end
    	end
    	@users = User.where(id: users)
	end
	def create
		@invite_group = InviteGroup.create(invite_params)
		@invite_group.invite_user = session[:user_id]
		@invite_group.save
		@user = params[:invite_group][:invited_user]
		@group = params[:invite_group][:group_id]
		@invited_user = User.find(@user)
		@group = Group.find(@group)
	end
	def index
		@invites = InviteGroup.where(invited_user: session[:user_id])
		@invite = BelongUserToGroup.new
	end
	def destroy
		@invite = InviteGroup.find(params[:id])
		@invite.destroy
		@invite.save
		redirect_to '/invite/index'
	end

	private
	def invite_params
		params.require(:invite_group).permit(:invited_user, :group_id)
	end
	def check
		invite = InviteGroup.where(invite_user: session[:user_id], invited_user: params[:invite_group][:invited_user], group_id: params[:invite_group][:group_id]).count
		group = BelongUserToGroup.where(group_id: params[:invite_group][:group_id], user_id: params[:invite_group][:user_id]).count
		if invite != 0
			redirect_to "/index"
		elsif group != 0
			redirect_to "/index"
		end
	end
end
