require 'prawn'
class CustomersController < ApplicationController
	before_action :current_user #, :require_customer

  def index
    @show_restaurant = Restaurant.all
    @items = Item.all
  end
  
  def show_all_restaurant
    @show_restaurant = Restaurant.all
  end

  def show_items
    @restaurant = Restaurant.find(params[:id])
    @items = @restaurant.items
  end

  def current_user
    @user = User.find_by(id: session[:user_id])
		if @user.type == "Customer"
		else
			redirect_to login_path
			flash[:error] = "Only Customer can Access This Page "
		end
	end

  def generate_invoice
    pdf = Prawn::Document.new
    item_id = params[:item_id]
    pdf.text "Invoice\n\n"    
    orders = Order.joins(:item).where(items: { id: item_id }, status: "Delivered")
    orders.each do |order|
      pdf.text "Customer Name :- #{order.name}"
      pdf.text "Item Name :- #{order.item.name}"
      pdf.text "Total Amount :- #{order.price}"
      pdf.text "Address :- #{order.address}"
      pdf.text "Quantity :- #{order.quantity}"
      pdf.move_down 5
    end

    filename = "invoice_#{Time.now.strftime("%Y%m%d_%H%M%S")}.pdf"
    pdf.render_file(Rails.root.join('public', 'pdfs', filename))
    send_data pdf.render, filename: filename, type: "application/pdf", disposition: "inline"
  end

  # def require_customer
	# 	unless current_user && current_user.is_customer?
	# 	  flash[:error] = "You must be an admin to access this page"
	# 	  redirect_to root_path
	# 	end
	# end
end
