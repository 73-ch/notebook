class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper
  include NotesHelper
  include CategoriesHelper
  include HomeHelper
  	def login_checker
		if session[:user_id] == nil
			redirect_to new_session_path
		end
	end
end
