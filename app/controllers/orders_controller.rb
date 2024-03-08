# app/controllers/orders_controller.rb
class OrdersController < ApplicationController
	before_action :current_user

  def new_order
    @item = Item.find(params[:item_id])
    @order = Order.new
  end

  def create_order
    # binding.irb
    @order = Order.new(order_params.merge(customer_id: session[:user_id]))
    @item = Item.find(params[:order][:item_id]) 
    @order.status = 'pending'
    @order.price = @item.price
    @order.item_id = @item.id
    if @order.save
      redirect_to customers_index_path
      flash[:success] = "Order placed successfully"
    else
      redirect_to customers_index_path
      flash[:error] =  "not ok"
    end
  end

  def order_history
    @order = Order.where(customer_id: session[:user_id])
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

  def order_params
    params.require(:order).permit(:quantity, :price, :item_id, :status, :address , :name,:contact)
  end
end
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