class UsersController < ApplicationController
 before_action :authenticate_user!




 def show
  @user = User.find(params[:id])
  @book = Book.new
  @books =@user.books
 end

def edit
 @user = User.find(params[:id])
if current_user.id != @user.id
redirect_to user_path(current_user.id)
end
end

def update
 @user= User.find(params[:id])
if @user.update(user_params)
 flash[:notice]= "Profile was successfully updated."
 redirect_to user_path(@user.id)
else
 render :edit
end
end

def index
 @book = Book.new
 @users =User.all
 @user = current_user
end



private
def user_params
 params.require(:user).permit(:name, :profile_image,:introduction)
end




end
