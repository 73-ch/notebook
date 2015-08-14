module HomeHelper
	def not_login
		if session[:user_id] != nil
			redirect_to index_path
		end
	end
end
