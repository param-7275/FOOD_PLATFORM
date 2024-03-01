class AdminsController < ApplicationController
	before_action :current_user
	def index
	end

	def show
		@owners = Owner.includes(:restaurant).all
	end
  def new_signup
		@admin = Admin.new
	end

	def admin_signup
		@admin = Admin.new(admin_params)
		if @admin.save
			flash[:success] = "Account Sucessfully Created"
		else
			flash[:error] = @admin.errors.full_messages
			render :new_signup
		end
	end

	def new_login
		@admin = Admin.new
	end

	def admin_login
		@admin = Admin.find_by(email: params[:admin][:email])
		if @admin && @admin.authenticate(params[:admin][:password])
			@admin.role == Admin
			session[:admin_id] = @admin.id
			flash[:success] = "Login successful!"
			redirect_to owners_path
		else
			@owner = Owner.find_by(email: params[:owner][:email])
			if @owner && @owner.authenticate(params[:owner][:password])
				@admin.role == Admin
				session[:owner_id] = @owner.id
				flash[:success] = "Login successful!"
				redirect_to index_path
			else
				flash[:error] = 'Invalid email or password'
				render :new_login
			end
		end
	end

	def destroy
		if params[:id].present?
			session[:user_id] = nil
			flash[:notice] = 'User  successfully logged out.'
		end
		redirect_to root_path
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
	def admin_params
		params.require(:admin).permit(:email, :password, :password_confirmation)
	end
end
