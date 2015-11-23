class HomeController < ApplicationController
	before_action :login_checker
  def top
  	not_login
  end

  def new
  end
end
