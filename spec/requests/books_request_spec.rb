require 'rails_helper'

RSpec.describe 'BooksController', type: :request do
  describe 'GET /index' do
    subject(:get_index) { get("/books", params:) }

    context 'when successful' do
      it do
        get_index
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when filtering' do
      let(:params) do
        {
          q: {
            title_eq: 'test'
          }
        }
      end

      it do
        get_index
        expect(response).to have_http_status(:ok)
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