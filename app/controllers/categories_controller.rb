class CategoriesController < ApplicationController
	def new
		@category = Category.new
	end
	def destroy
		@category = Category.find(params[:id])
		@category.destroy
		redirect_to categories_path
	end
	def create
		@category = Category.create(category_params)
	end
	def edit
		@category = Category.find(params[:id]) 
	end

	def index     
		@categories = Category.all
	end
	def show
		categories = Category.where(user_id: session[:user_id])
		@category = categories.find(params[:id])
		@notes = Note.where(user_id: session[:user_id],category_id: @category.id)
	end

	private
	def category_params
		params.require(:category).permit(:category_type, :user_id, :name, :color)
	end
end