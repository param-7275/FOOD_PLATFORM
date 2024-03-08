class OwnersController < ApplicationController
	before_action :current_user , except: [:send_new_request , :send_request] #,:require_owner

  def index
  end

  def send_new_request
    @sendrequest = User.new
  end

  def order_update
    # binding.irb
    @order_update = Order.find_by(id: params[:id])
    if @order_update
      if @order_update.update(status: "Delivered")
        redirect_to owner_index_path
        flash[:notice] = 'Order was successfully Delivered.'
      else
        redirect_to pending_orders_path
        flash[:notice] =  'Failed to Delivered Order .'
      end
    else
      redirect_to owner_index_path
      flash[:notice] =  'Order detail not found.'
    end
	end

  def send_request
    binding.irb
    @sendrequest = User.new(owner_params)
    if @sendrequest.save
      flash[:success] = "Request Successfully Sent!"
      redirect_to root_path
    else
      render :send_new_request
    end
  end

	def showstaff
    @owner = current_user
    @restaurant_id = @owner.restaurant.id
		@staff = Staff.where(restaurant_id: @restaurant_id)
	end 

	def add_staff
		@staff = Staff.new
	end

	def add_s
    @owner = current_user
    if @owner.restaurant.present?
      @restaurant_id = @owner.restaurant.id
      @staff = Staff.new(staff_params.merge(restaurant_id: @restaurant_id))
      if @staff.save
        flash[:success] = "Staff Successfully Added!"
        redirect_to show_staff_path
      else
        render :add_staff
      end
    end
	end

  def pending_orders
    # binding.irb
    @restaurant = current_user.restaurant 
    @pending_orders = @restaurant.orders.where(status: 'pending')
  end

  def delivered_order
    # binding.irb
    @restaurant = current_user.restaurant 
    @delivered_orders = @restaurant.orders.where(status: 'Delivered')
  end

	def show_item
		@owner = current_user
    @restaurant_id = @owner.restaurant.id
		@item = Item.where(restaurant_id: @restaurant_id)
	end

	def add_item
		@item = Item.new
	end

	def add_i
		@owner = current_user
    if @owner.restaurant.present?
      @restaurant_id = @owner.restaurant.id
      @item = Item.new(item_params.merge(restaurant_id: @restaurant_id))
      if @item.save
        flash[:success] = "Item Successfully Added!"
        redirect_to show_item_path
      else
        render :add_item
      end
    end
	end

	def showrestaurant
		@restaurant = Restaurant.where(owner_id: session[:user_id])
	end

	def addrestaurant
		@restaurant = Restaurant.new
	end

	def add_r
		# binding.irb
		@restaurant = Restaurant.new(restaurant_params.merge(owner_id: session[:user_id]))
		if @restaurant.save
			flash[:success] = "Restaurant Successfully Added!"
			redirect_to show_restaurant_path
		else
			render :addrestaurant_path
		end
	end

	def current_user
    if session[:user_id]
      @user = User.find_by(id: session[:user_id])
      # if @user.type == "Customer"
      # end
    else
      redirect_to login_path
      flash[:error] = "Must be login"
    end
  end

	def delete_staff
		@staff = Staff.find(params[:id])
		@staff.destroy
		flash[:success] = "Staff sucessfuly Deleted"
		redirect_to show_staff_path
	end

	def delete_item
		@item = Item.find(params[:id])
		@item.destroy
		flash[:success] = "item sucessfuly Deleted"
		redirect_to show_item_path
	end

	private
	def restaurant_params
		params.require(:restaurant).permit(:name, :address , :image)
	end

	def staff_params
		params.require(:staff).permit(:name, :specialization, :contact)
	end

	def item_params
		params.require(:item).permit(:name, :description, :price, :image)
	end

  def owner_params
    params.require(:user).permit(:username , :email, :r_name, :r_address, :contact)
  end

  # def require_owner
	# 	unless current_user && current_user.is_owner?
	# 	  flash[:error] = "You must be an admin to access this page"
	# 	  redirect_to root_path
	# 	end
	# end
end
