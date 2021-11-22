require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  describe 'GET index' do
    context 'when there are no categories' do
      it 'returns an empty list' do
        get '/api/v1/categories'

        expect(JSON.parse(response.body)).to be_empty
      end
    end

    context 'when there are categories' do
      before do
        FactoryBot.create(:category, name: 'Tecnologia', url: 'http://localhost:3000/api/v1/categories/1')
        FactoryBot.create(:category, name: 'Direito', url: 'http://localhost:3000/api/v1/categories/2')
      end

      it 'returns 2 items' do
        get '/api/v1/categories'

        expect(JSON.parse(response.body).count).to eq(2)
      end

      it 'returns a list' do
        get '/api/v1/categories'

        expect(JSON.parse(response.body).map(&:symbolize_keys).first).to include(
          name: 'Tecnologia',
          url: 'http://localhost:3000/api/v1/categories/1'
        )

        expect(JSON.parse(response.body).map(&:symbolize_keys).last).to include(
          name: 'Direito',
          url: 'http://localhost:3000/api/v1/categories/2'
        )
      end

      it 'returns the correct HTTP status' do
        get '/api/v1/categories'

        expect(response).to have_http_status(:ok)
      end

      it 'returns the correct content_type' do
        get '/api/v1/categories'

        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end


  describe 'GET show' do
    before do
      FactoryBot.create(:category, name: 'Tecnologia', url: 'http://localhost:3000/api/v1/categories/1')
    end

    it 'renders a successful response' do
      get '/api/v1/categories/1'

      expect(response).to be_successful
    end
  end



  describe 'POST create' do
    it 'creates a category' do
      expect do
        post '/api/v1/categories', params: {
          category: FactoryBot.attributes_for(:category)
        }
      end.to change(Category, :count).by(1)
    end

    it 'returns the correct HTTP status' do
      post '/api/v1/categories', params: {
        category: FactoryBot.attributes_for(:category)
      }

      expect(response).to have_http_status(:created)
    end

    it 'returns the correct content_type' do
      post '/api/v1/categories', params: {
        category: FactoryBot.attributes_for(:category)
      }

      expect(response.content_type).to eq('application/json; charset=utf-8')
    end
  end

  
  describe 'PATCH update' do
    context 'with valid parameters' do
      before do
        @category_update = FactoryBot.create(:category, name: 'Direito', url: 'http://localhost:3000/api/v1/categories/2')
      end

      it 'update a post' do
        patch '/api/v1/categories/1', params: {
          category: {
            name: 'Tecnologia'
            }
          }
        @category_update.reload
        expect(@category_update[:name]).to eq(FactoryBot.attributes_for(:category)[:name]) 
      end

      it 'returns the correct HTTP status' do
        patch '/api/v1/categories/1', params: {
          category: FactoryBot.attributes_for(:category)
        }
        expect(response).to have_http_status(:accepted)
      end

      it 'returns the correct content_type' do
        patch '/api/v1/categories/1', 
        params: { category: FactoryBot.attributes_for(:category)}
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
      
    end

    context 'with invalid parameters' do
      before do
        FactoryBot.create(:category, name: 'Tecnologia', url: 'http://localhost:3000/api/v1/categories/1')
      end
      it 'renders a JSON response with errors' do
        patch '/api/v1/categories/1',
          params: { category: { name: nil } }
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'DELETE destroy' do
    before do
      FactoryBot.create(:category, name: 'Tecnologia', url: 'http://localhost:3000/api/v1/categories/1')
    end
    
    it 'destroys the requested category' do
      expect do
        delete '/api/v1/categories/1'
      end.to change(Category, :count).by(-1)
    end
  end

end
