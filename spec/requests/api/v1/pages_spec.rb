require 'rails_helper'

RSpec.describe 'Pages', type: :request do
  before do
    FactoryBot.create(:category, name: 'Tecnologia', url: 'http://localhost:3000/api/v1/categories/1')
    FactoryBot.create(:article, title: 'Sed pretium rhoncus nibh a rhoncus.', active: true, category_id: 1)
  end

  describe 'GET show' do
    before do
      FactoryBot.create(:page, number: 1, content: 'Sed pretium rhoncus nibh a rhoncus. Proin hendrerit tellus', article_id: 1)
    end

    it 'renders a successful response' do
      get '/api/v1/pages/1'

      expect(response).to be_successful
    end
  end

  describe 'POST create' do
    it 'creates the pages of article' do
      expect do
        post '/api/v1/pages', params: {
          page: FactoryBot.attributes_for(:page)
        }
      end.to change(Page, :count).by(1)
    end

    it 'returns the correct HTTP status' do
      post '/api/v1/pages', params: {
        page: FactoryBot.attributes_for(:page)
      }

      expect(response).to have_http_status(:created)
    end

    it 'returns the correct content_type' do
      post '/api/v1/pages', params: {
        page: FactoryBot.attributes_for(:page)
      }

      expect(response.content_type).to eq('application/json; charset=utf-8')
    end
  end

  describe 'PATCH update' do
    context 'with valid parameters' do
      before do
        @page_update = FactoryBot.create(:page, number: 1, content: 'Sed pretium r', article_id: 1)
      end

      it 'update a post' do
        patch '/api/v1/pages/1', params: {
          page: {
            content: 'Sed pretium rhoncus nibh a rhoncus. Proin hendrerit tellus',
            }
          }
        @page_update.reload
        expect(@page_update[:content]).to eq(FactoryBot.attributes_for(:page)[:content]) 
      end

      it 'returns the correct HTTP status' do
        patch '/api/v1/pages/1', params: {
          page: FactoryBot.attributes_for(:page)
        }
        expect(response).to have_http_status(:accepted)
      end

      it 'returns the correct content_type' do
        patch '/api/v1/pages/1', 
        params: { page: FactoryBot.attributes_for(:page)}
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
      
    end

    context 'with invalid parameters' do
      before do
        FactoryBot.create(:page, number: 1, content: 'Sed pretium rfhana', article_id: 1)
      end

      it 'renders a JSON response with errors' do
        patch '/api/v1/pages/1',
          params: { page: { content: nil} }
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end

      it 'returns the correct HTTP status ( BAD RESQUEST )' do
        patch '/api/v1/pages/1',
          params: { page: { content: nil} }
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'DELETE destroy' do
    before do
      FactoryBot.create(:page, number: 1, content: 'Sed pretium rfafas vvvasv wrs', article_id: 1)
    end
    
    it 'destroys the pages of an article' do
      expect do
        delete '/api/v1/pages/1'
      end.to change(Page, :count).by(-1)
    end
  end

end
