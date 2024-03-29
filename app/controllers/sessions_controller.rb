class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Sign the user in and redirect to the user's show page.
      sign_in( user )
      redirect_back_or ( user )
      
    else
      flash.now[:error] = 'Invalid email/password combination' # use of flash.now enesures that the flash doesn't persist
      														   # longer than it should
      														   
      render 'new' # go to new.html.erb
    end
  end

  def destroy
  
  	sign_out
  	redirect_to root_url
  end
end