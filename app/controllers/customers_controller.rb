class CustomersController < ApplicationController
	before_action :current_user

  def index
  end

  def current_user
    if session[:user_id]
      @user = User.find_by(id: session[:user_id])
    else
      redirect_to login_path
      flash[:error] = "Must be login"
    end
  end
end
