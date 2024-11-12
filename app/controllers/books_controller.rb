class BooksController < ApplicationController
  before_action :fetch_book, only: %i[show update destroy]

  def index
    @books = Book.ransack(params[:q]).result

    render json: @books
  end

  def show
    render json: @book
  end

  def update
    @book.update(permit_params)

    render json: @book
  end

  def destroy
    @book.destroy!

    head :nothing
  end

  private

  def fetch_book
    @book = Book.find(params.require(:id))
  end

  def permit_params
    params.require(:book).permit(:title, :author, :publication_year)
  end
end
