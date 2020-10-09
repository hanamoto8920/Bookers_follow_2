class BooksController < ApplicationController

  before_action :authenticate_user!

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user

  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @user = current_user
    if @book.save
    redirect_to book_path(@book.id), notice: "本を投稿"
    else
      @books = Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    @user = @book.user
    if @user.id != current_user.id
      redirect_to books_path
    end
  end

  def show
    @book = Book.find(params[:id])
    @new = Book.new
    @user = current_user


  end

  def update
    @book = Book.find(params[:id])
   if @book.update(book_params)
     redirect_to book_path(@book.id), notice: "更新しました"
   else
     render :edit
   end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path, notice: "削除しました"
  end

  private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end


end
