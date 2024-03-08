class OwnerMailer < ApplicationMailer
  default from: 'paramjeet6779@gmail.com'

  def request_rejected
    # binding.irb
    @owner_detail = params[:request]
    mail(to: @owner_detail.email, subject: 'Your request has been rejected')
  end

  def welcome_email
    binding.irb
    @user =  params[:user]
    #@url  = 'http://yourwebsite.com/login' # Set the login URL
    mail(to: @user.email, subject: 'Welcome to My Website!')
  end
end
