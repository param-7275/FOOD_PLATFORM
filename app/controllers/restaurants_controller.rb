class RestaurantsController < ApplicationController
  def items
      @restaurant = Restaurant.find(params[:id])
      @items = @restaurant.items
  end 
end
