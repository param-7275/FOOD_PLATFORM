class OwnerdetailsController < ApplicationController

  def send_new_request
    @ownerdetail = OwnerDetail.new
  end

  def send_request
    @ownerdetail = OwnerDetail.new(request_params)
    if @ownerdetail.save
      flash[:success] = "Request Successfully Sent!"
      redirect_to root_path
    else
      render :send_new_request
    end
  end
  

  private
  def request_params
    params.require(:owner_detail).permit(:username , :email, :r_name, :r_address, :contact)
  end
end
