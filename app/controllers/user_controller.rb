class UserController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    @user_meets = @user.meets.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Hello #{@user.username} \n Welcome to the Room Booking "      
      redirect_to new_meet_path
    else      
        render 'new'      
    end
  end
  
  def edit
  end

  def update
    if @user.update(user_params)    
      flash[:success] = "Your account was updated successfully"    
      redirect_to user_path(@user)   
    else    
      render 'edit'    
    end
  end

  def destroy
    @user.destroy
    flash[:danger] = "User and all articles created by user have been deleted"
    redirect_to user_index_path
  end

  private  
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :password)
    end
end
