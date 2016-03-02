class CategoriesController < ApplicationController
	before_action :login_checker
	def new
		@category = Category.new
	end
	def destroy
		@category = Category.find(params[:id])
		@category.destroy
		redirect_to categories_path
	end
	def create
		@category = Category.new(category_params)
		@category.opp_color = opp_color(params[:category][:color])
		@category.save
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
	def opp_color(color)
		data = color.delete('#')
		rgb =  data.scan(/.{1,2}/)
		r = rgb[0].hex
		g = rgb[1].hex
		b = rgb[2].hex
		if r === g && g === b
			cr = (255 - r).to_s(16)
			cg = (255 - g).to_s(16)
			cb = (255 - b).to_s(16)
		else
			sum = [r, g, b].minmax.inject(:+)
			cr = (sum - r).to_s(16)
			cg = (sum - g).to_s(16)
			cb = (sum - b).to_s(16)
		end
		if cr < 16.to_s(16)
			cr = "0" + cr
		end
		if cg < 16.to_s(16)
			cg = "0" + cg
		end
		if cb < 16.to_s(16)
			cb = "0" + cb
		end
		return '#' + cr + cg + cb
	end
end