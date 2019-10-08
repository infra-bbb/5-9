class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: "You have creatad book successfully."
    else
      @books = Book.all
      render :index
    end
  end

  def index
    @books = Book.all
    @book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end
  
  def destroy
    book = Book.find(params[:id]) #データ(レコード)を1件取得
    book.destroy #データ（レコード）を削除
    redirect_to books_path
  end

  def show
    @books = Book.find(params[:id])
    @book = Book.new
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully." 
    else
      render :edit
    end
  end

  private
  def book_params
      params.require(:book).permit(:title, :body, :user_id)
  end

  def ensure_correct_user
    check = Book.find(params[:id])
    if current_user != check.user
     redirect_to books_path
    end
  end

end
