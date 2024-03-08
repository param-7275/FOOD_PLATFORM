class SessionsController < ApplicationController
  before_action :current_user, only: [:new_owner]

  def index
  end

  def new_signup
    @user = User.new
  end

  def user_signup
    @user = Customer.create(user_params)
		if @user.save
			flash[:success] = "Account Sucessfully Created"
      redirect_to login_path
		else
			flash[:error] = @user.errors.full_messages
			render :new_signup
		end
  end

  def new_owner
		render :new_owner
	end

	def create_owner
		@owner = User.new(owner_params)
		if @owner.save
			flash[:success] = "Owner Sucessfully Created"
      # OwnerMailer.with(user: @user).welcome_email.deliver_now  
      redirect_to admin_index_path
		else
			flash[:error] = @owner.errors.full_messages
			render :new_owner
		end
	end
  

  def new_login
		@user = User.new
	end

  def user_login
    @user = User.find_by(email: params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
      case @user.type
      when "Admin"
        session[:user_id] = @user.id
        flash[:success] = "Login successful!"
        redirect_to admin_index_path
      when "Owner"
        session[:user_id] = @user.id
        flash[:success] = "Login successful!"
        redirect_to owner_index_path
      when "Customer"
        session[:user_id] = @user.id
        flash[:success] = "Login successful!"
        redirect_to customers_index_path
      else
        flash[:error] = "Unsupported user type"
        render :new_login
      end
    else
      flash[:error] = "Invalid email or password"
      render :new_login
    end
  end

	def destroy
		if session[:user_id].present?
			session[:user_id] = nil
			flash[:success] = 'User successfully logged out.'
		end
		redirect_to login_path
	end

  # def current_user
  #   if session[:user_id]
  #     @user = User.find_by(id: session[:user_id])
  #   else
  #     redirect_to login_path
  #     flash[:error] = "Must be login"
  #   end
  # end

  def current_user
    @user ||= User.find_by(id: session[:user_id])
    redirect_to login_path, flash: { error: "Must be logged in" } unless @user
  end

  private
	def user_params
    params.require(:user).permit(:username, :email, :type, :password, :password_confirmation,:contact)
  end
  def owner_params
    params.require(:admin).permit(:username, :email, :type, :password, :password_confirmation , :contact)
  end 
end
