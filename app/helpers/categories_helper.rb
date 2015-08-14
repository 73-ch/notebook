module CategoriesHelper
	def login_checker
		if session[:user_id] == nil
			redirect_to new_session_path
		end
	end
end
