class BooksController < ApplicationController
before_action :authenticate_user!, except: [:top]
  def new
    @newbook = Book.new
  end

  def create
    @newbook = Book.new(book_params)
    @newbook.user_id = current_user.id
  if @newbook.save
    redirect_to book_path(@newbook), notice: 'successfully'
  else
    @books = Book.all
    @user = current_user
    flash.now[:alert] = 'error'
    render :index
  end
  end

  def index
    @books = Book.all
    @user = current_user
    @newbook = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @newbook = Book.new
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def edit
    @book = Book.find(params[:id])
  if @book.user == current_user
        render :edit
  else
        redirect_to books_path
  end
  end


  def update
    @book = Book.find(params[:id])
  if  @book.update(book_params)
    redirect_to book_path(@book.id), notice: 'successfully'
  else
    flash.now[:alert] = 'error'
    render :edit
  end
  end

  private

  def book_params
  params.require(:book).permit(:title, :body)
  end

end