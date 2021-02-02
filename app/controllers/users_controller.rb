class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books =@user.books
  end

  def edit
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user= User.find(params[:id])
   if @user.update(user_params)
     flash[:notice]= "successfully"
    redirect_to user_(@user.id)
   else
     render :edit
   end
  end


  def index
    @users = User.all
    @user = User.find(current_user.id)
    @book = Book.new
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image,:introduction)
  end
end
