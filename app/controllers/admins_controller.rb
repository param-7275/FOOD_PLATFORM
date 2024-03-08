class AdminsController < ApplicationController
	before_action :current_user #, :require_admin
	def index
	end

	def show_owner
		@owners = Owner.includes(:restaurant).all
	end

  def request_update
    # binding.irb
    @owner_detail = OwnerDetail.find_by(id: params[:id])
    if @owner_detail
      if @owner_detail.update(status: true)
        redirect_to show_update_request_path
        flash[:notice] = 'Owner detail was successfully accepted.'
      else
        redirect_to show_request_path
        flash[:notice] =  'Failed to update owner detail status.'
      end
    else
      redirect_to show_request_path
      flash[:notice] =  'Owner detail not found.'
    end
  end

  def show_update_request
		@showupdaterequest = OwnerDetail.where(status: true)
	end

	def show_request
		@showrequest = OwnerDetail.where(status: false)
	end

	def destroy
		if params[:id].present?
			session[:user_id] = nil
			flash[:notice] = 'User  successfully logged out.'
		end
		redirect_to root_path
	end

	def current_user
    @user = User.find_by(id: session[:user_id])
		if @user.type == "Admin"
		else
			redirect_to login_path
			flash[:error] = "Must be login"
		end
	end

  def delete_request
    @request = OwnerDetail.find(params[:id])
		@request.destroy
		flash[:success] = "Request Sucessfully Rejected"
    OwnerMailer.with(request: @request).request_rejected.deliver_now
  end

  def delete_owner
    @request = User.find(params[:id])
		@request.destroy
		flash[:success] = "Owner Sucessfully Deleted!"
    # OwnerMailer.with(request: @request).request_rejected.deliver_now
  end

  private
	def owner_params
		params.require(:user).permit(:username, :email, :type, :password, :password_confirmation)
	end


	# def require_admin
	# 	unless current_user && current_user.is_admin?
	# 	  flash[:error] = "You must be an admin to access this page"
	# 	  redirect_to root_path
	# 	end
	# end
end
