class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:top]
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @newbook = Book.new
  end

  def edit
    @user = User.find(params[:id])
  if @user == current_user
    render :edit
  else
    redirect_to user_path(current_user)
  end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have update user successfully"
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def index
    @users = User.all
    @user = current_user
    @newbook = Book.new
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
