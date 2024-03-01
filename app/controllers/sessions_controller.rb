class SessionsController < ApplicationController
	# before_action :current_user

  def index
  end

  def new_signup
    @user = User.new
  end

  def user_signup
    @user = Customer.create(user_params)
		if @user.save
			flash[:success] = "Account Sucessfully Created"
		else
			flash[:error] = @user.errors.full_messages
			render :customer_new
		end
  end
  def new_login
		@user = User.new
    # Customer.create(customer_params)
    # User.last
	end

  def user_login
    @user = User.find_by(email: params[:user][:email])

    if @user && @user.authenticate(params[:user][:password])
      case @user.type
      when "Admin"
        session[:user_id] = @user.id
        flash[:success] = "Login successful!"
        redirect_to customers_index_path
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
    # binding.irb
		if session[:user_id].present?
			session[:user_id] = nil
			flash[:success] = 'User successfully logged out.'
		end
		redirect_to login_path
	end
  def current_user
    if session[:user_id]
      @user = User.find_by(id: session[:user_id])
    else
      redirect_to login_path
      flash[:error] = "Must be login"
    end
  end
  private
	def user_params
		params.require(:user).permit(:username,:email, :password, :password_confirmation)
	end
  
end
