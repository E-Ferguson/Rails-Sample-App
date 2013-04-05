class UsersController < ApplicationController


  before_filter :signed_in_user, only: [:index, :edit, :update]
  before_filter :correct_user  , only: [:edit, :update]
  before_filter :admin_user    , only: :destroy   #only an admin can destroy

  def show #used to show a users page
  	@user = User.find(params[:id])
  end

  def new 
  	@user = User.new
  end
  
  def create
  	@user = User.new(params[:user])
  	if @user.save   #if the form is valid
  		sign_in @user
  		flash[:success] = "Welcome to the app!"
  		redirect_to @user
  	else
  		render 'new' # that is, go to new.html.erb
  	end
  end
  
  
  # @user = User.find(params[:id]) no longer necessary in edit and update because it is defined
  # in before filters 
  
  def edit
  	#@user = User.find(params[:id])
  end
  
  
  #update code closely resembles the create code
  def update
  	#@user = User.find(params[:id])
  	if @user.update_attributes(params[:user])
  		# Handle successful update
  		flash[:success] = "Profile updated"
		sign_in @user #user is signed in and their remember token reset
		redirect_to @user
  	else
  		render 'edit'
  	end
  end
  
  
  def index
  	@users = User.paginate(page: params[:page])
  end
  	
  	
  def destroy
  	User.find(params[:id]).destroy  # note chaining
  	flash[:sucess] = "User destroyed"
  	redirect_to users_url
  end
  
  private # to define the before_filters, which are visible only within this class
  
  	def signed_in_user
  		store_location #For friendly forwarding
  		redirect_to signin_url, notice: "Please sign in." unless signed_in?
  	end
  
  
    def correct_user
	   @user = User.find(params[:id])
	   redirect_to(root_path) unless current_user?(@user)
	end
	
	
	def admin_user
		redirect_to(root_path) unless current_user.admin?
  	end
  	
end
