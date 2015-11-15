class WorksController < ApplicationController
	def new
		@work = Work.new
	end
	def create
		@work = Work.create(work_params)
		@work.save
	end
	def index
		works = Work.where(user_id: session[:user_id])
		categories = Category.where(user_id: session[:user_id])
		@all = works + categories
	end
	def show
		@work = Work.find(params[:id])
	end
	def destroy
		@work = Work.find(params[:id])
		@work.destroy
		@work.save
	end
	def edit
		
	end
	private
	def work_params
		params.require(:work).permit(:name, :color, :user_id)
	end
end
