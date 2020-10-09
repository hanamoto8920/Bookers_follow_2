class UsersController < ApplicationController

  before_action :authenticate_user!

  def index
    @user = current_user
    @users = User.all
    @book = Book.new
    @books = Book.all
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = Book.all
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to user_path(current_user)
    end

  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    redirect_to user_path, notice: "更新しました"
    else
     render :edit
    end

  end


  private
  def user_params
     params.require(:user).permit(:profile_image, :name, :introduction)
  end



end
