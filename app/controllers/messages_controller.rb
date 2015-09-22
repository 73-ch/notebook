class MessagesController < ApplicationController
	def index
    	@notes = Message.where(for_user: session[:user_id])
    	@users = User.all
	end

	def new
		@message = Message.new
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

  	def new_date
    	@message = Message.new
    	@users = User.where.not(id: session[:user_id])
  	end

  	def new_memo
    	@message = Message.new
    	@users = User.where.not(id: session[:user_id])
  	end

  	def create
  		@message = Message.create(message_params)
  		@message.user_id = session[:user_id]
  	end

  	def show
  		messages = Message.where(for_user: session[:user_id])
  		@message = messages.find(params[:id])
  	end

  	private
  	
  	def message_params
  		params.require(:message).permit(:message_type, :title, :content, :important, :start_time, :end_time, :site_url, :for_user)
  	end
end
