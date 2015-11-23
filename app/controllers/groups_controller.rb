class GroupsController < ApplicationController
	before_action :login_checker
	def new
		@group = Group.new
	end
	def create
		@group = Group.new(group_params)
		@group.user_id = session[:user_id]
		@group.save
		@belong_user_to_group = BelongUserToGroup.new
		@belong_user_to_group.user_id = session[:user_id]
		@belong_user_to_group.group_id = @group.id
		@belong_user_to_group.save
	end
	def destroy
		@group = Group.find(params[:id])
    	@group.destroy
    	redirect_to 
	end
	def edit
		@group = Group.find(params[:id])
	end
	def show
		@group = Group.find(params[:id])
	end
	def update
    	if @group.update_attributes(group_params)
      		redirect_to @group
    	else
      		render 'edit'
    	end
  	end
  	def index
  		belongs = BelongUserToGroup.where(user_id: session[:user_id])
  		group_ides = []
  		belongs.each do |belong|
  			group_ides.push(belong.group_id)
  		end
  		@groups = Group.where(id: group_ides)
  	end

	private
	def group_params
		params.require(:group).permit(:name)
	end
end
