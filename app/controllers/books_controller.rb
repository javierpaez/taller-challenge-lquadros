class BooksController < ApplicationController
  before_action :fetch_book, only: %i[show update destroy]

  def index
    # params[:q][:title_cont]
    # params[:q][:sort] = 'title desc'
    # publication_year and rating
    @books = Book.all.order('rating desc, publication_year desc')

    render json: @books
  end

  def show
    render json: @book
  end

  def update
    @book.update(permit_params)

    render json: @book
  end

  def create
    @book = Book.new(permit_params)

    if @book.save
      render json: @book, status: :created
    else
      render json: @book.errors.full_messages, status: :unprocessable_entity
    end
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
