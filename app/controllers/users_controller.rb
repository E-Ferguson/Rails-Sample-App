class UsersController < ApplicationController

  def show #used to show a users page
  	@user = User.find(params[:id])
  end

  def new 
  	@user = User.new
  end
  
  def create
  	@user = User.new(params[:user])
  	if @user.save   #if the form is valid
  		flash[:success] = "Welcome to the vagina_boo!"
  		redirect_to @user
  	else
  		render 'new' # that is, go to new.html.erb
  	end
  end
  
end
