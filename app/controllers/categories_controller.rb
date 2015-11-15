class CategoriesController < ApplicationController


	def new
		login_checker
		@category = Category.new
	end

	def destroy
		login_checker
		@category = Category.find(params[:id])
		@category.destroy
		redirect_to categories_path
	end

	def create
		login_checker
		@category = Category.create(category_params)
		@category.user_id = session[:user_id]
		@category.save
	end

	def edit
		login_checker
		@category = Category.find(params[:id]) 
	end

	def index  
		login_checker   
		@categories = Category.all
	end
	def show
		login_checker
		categories = Category.where(user_id: session[:user_id])
		@category = categories.find(params[:id])
		@notes = Note.where(user_id: session[:user_id],category_id: @category.id)
	end

	private
	def category_params
		params.require(:category).permit(:name, :color)
	end
end