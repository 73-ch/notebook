class FollowsController < ApplicationController
  def index
    @follows = Follow.where(user_id: session[:user_id])
    @followeds = Follow.where(followed_id: session[:user_id])
  end
  def new
    @follow = Follow.new
    @users = User.where.not(id: session[:user_id])
  end

  def create
    @follow = Follow.create(follow_params)
    @follow.user_id = session[:user_id]
    @follow.save
  end

  private
    def follow_params
      params.require(:follow).permit(:followed_id)
    end
end
