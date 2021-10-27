class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:top]
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @newbook = Book.new
  end
  
  def edit
    @user = User.find(params[:id])
  if @user.book == current_user
        render :edit
  else
        redirect_to users_path
  end
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end  

  def index
    @users = User.all
    @user = current_user
    @newbook = Book.new
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :profile_image, :plofile_introduction)
  end  
end
