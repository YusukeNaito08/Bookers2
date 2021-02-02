class BooksController < ApplicationController

def index
    @books =Book.all
    @user = User.find(current_user.id)
    @book = Book.new
 end

  def show
    @book_show = Book.find(params[:id])
    @user = User.find(@book_show.user_id)
    @book = Book.new
  end

  def create
    @book =Book.new(book_params)
    @book.user_id = current_user.id
   if @book.save
     flash[:notice]="successfully"
    redirect_to book_path(@book.id)
   else
     render :show
   end
  end

  def edit
    @book = Book.find(params[:id])
    if current_user != @book.user
      redirect_to user_path(current_user)
    end
  end

  def update
    @book = Book.find(params[:id])
   if  @book.update(book_params)
     flash[:notice]="successfully"
    redirect_to book_path(@book.id)
   else 
    render :edit
   end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end

