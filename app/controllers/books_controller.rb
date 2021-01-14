class BooksController < ApplicationController

before_action :correct_user, only: [:edit, :update]
 before_action :authenticate_user!

def create
 @book= Book.new(book_params)
 @book.user_id = current_user.id
 if @book.save(book_params)
 @user = @book.user
 redirect_to user_path(@user.id)
 flash[:notice]= "Book was successfully created."
 else
   @books = Book.all
   @user = current_user
  render :index
 end
end

def index
 @book = Book.new
 @books = Book.all
 @user = User.find(current_user.id)
end

def show
 @book = Book.find(params[:id])
 @user = @book.user
end

def edit
 @book = Book.find(params[:id])
end

def update
  @book = Book.find(params[:id])
 if  @book.update(book_params)
   @user = @book.user
   flash[:notice]= "Book was successfully updated"
  redirect_to user_path(@user.id)
 else
   render :edit
 end
end

def destroy
 @book = Book.find(params[:id])
 @book.destroy
 @user = @book.user
 redirect_to user_path(@user.id)
end

private
def book_params
 params.require(:book).permit(:title, :body)
end

private
def correct_user
      book = Book.find(params[:id])
      if current_user.id != book.user.id
      redirect_to user_session_path
      end
end

end
