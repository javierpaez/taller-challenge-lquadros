require 'rails_helper'

RSpec.describe 'BooksController', type: :request do
  describe 'GET /index' do
    subject(:get_index) { get("/books", params:) }

    let(:params) { {} }

    context 'when successful' do
      it do
        get_index
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when sorting' do
      let(:expected_response) do
        books.as_json
      end

      let(:books) do
        [
          create(:book, rating: 5, publication_year: Date.today.year),
          create(:book, rating: 5, publication_year: 2.years.ago.year),
          create(:book, rating: 4, publication_year: Date.today.year)
        ]
      end

      before { books }

      it do
        get_index
        expect(response).to have_http_status(:ok)
      end

      it do
        get_index
        expect(JSON.parse(response.body)).to eq(expected_response)
      end
    end
  end

  describe 'GET /show' do
    subject(:get_show) { get(book_path(book), params:) }

    let(:book) { create(:book) }

    it do
      get_show
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /create' do
    subject(:post_create) { post(books_path, params:) }

    let(:params) { { book: book_attributes } }

    context 'when sucessful' do

      let(:book_attributes) { attributes_for(:book) }

      it do
        post_create
        expect(response).to have_http_status(:ok)
      end
  
      it do
        expect do
          post_create
        end.to change(Book, :count).by(1)
      end
    end

    context 'when failure' do
      let(:book_attributes) { attributes_for(:book).merge(title: nil) }

      it do
        post_create
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    subject(:patch_update) { patch(book_path(book), params:) }
    
    let(:book) { create(:book) }
    let(:params) { { book: attributes_for(:book)} }

    it do
      patch_update
      expect(response).to have_http_status(:ok)
    end
    
    it do
      expect do
        patch_update
        book.reload
      end.to change(book, :title)
      
    end
  end

  describe 'delete /destroy' do
    subject(:delete_destroy) { delete(book_path(book), params:) }

    it do
      patch_update
      expect(response).to have_http_status(:ok)
    end
  end
end