class OwnersController < ApplicationController
	before_action :current_user

  def index
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
    # binding.irb
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

	def show_item
		@owner = current_user
    @restaurant_id = @owner.restaurant.id
		@item = Item.where(restaurant_id: @restaurant_id)
	end

	def add_item
		@item = Item.new
	end

	def add_i
		# binding.irb
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
		params.require(:restaurant).permit(:name, :address)
	end

	def staff_params
		params.require(:staff).permit(:name, :specialization, :contact)
	end

	def item_params
		params.require(:item).permit(:name, :description, :price, :image)
	end
end
