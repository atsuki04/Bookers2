class BooksController < ApplicationController
  
  before_action :authenticate_user!

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
  if @book.save
    redirect_to books_path(@book), notice: 'successfully'
  else
    flash.now[:alert] = 'error'
    render :index
  end  
  end

  def index
    @books = Book.all
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end  
  
  def edit
    @book = Book.find(params[:id])

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
  params.permit(:title, :body)
  end

end