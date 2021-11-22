require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  before do
    FactoryBot.create(:category, name: 'Tecnologia', url: 'http://localhost:3000/api/v1/categories/1')
  end

  describe 'GET index' do
    context 'when there are no articles' do
      it 'returns an empty list' do
        get '/api/v1/articles'

        expect(JSON.parse(response.body)).to be_empty
      end
    end

    context 'when there are articles' do
      before do
        FactoryBot.create(:article, title: 'Sed pretium rhoncus nibh a rhoncus.', active: true, category_id: 1)
        FactoryBot.create(:article, title: 'Phasellus maximus elementum diam quis mollis.', active: true, category_id: 1)
      end

      it 'returns 2 items' do
        get '/api/v1/articles'

        expect(JSON.parse(response.body).count).to eq(2)
      end

      it 'returns a list' do
        get '/api/v1/articles'

        expect(JSON.parse(response.body).map(&:symbolize_keys).first).to include(
          title: 'Sed pretium rhoncus nibh a rhoncus.',
          active: true
        )

        expect(JSON.parse(response.body).map(&:symbolize_keys).last).to include(
          title: 'Phasellus maximus elementum diam quis mollis.',
          active: true
        )
      end

      it 'returns the correct HTTP status' do
        get '/api/v1/articles'

        expect(response).to have_http_status(:ok)
      end

      it 'returns the correct content_type' do
        get '/api/v1/articles'

        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'GET show' do
    before do
      FactoryBot.create(:article, title: 'Sed pretium rhoncus nibh a rhoncus.', active: true, category_id: 1)
    end

    it 'renders a successful response' do
      get '/api/v1/articles/1'

      expect(response).to be_successful
    end
  end

  describe 'POST create' do
    it 'creates a article' do
      expect do
        post '/api/v1/articles', params: {
          article: FactoryBot.attributes_for(:article)
        }
      end.to change(Article, :count).by(1)
    end

    it 'returns the correct HTTP status' do
      post '/api/v1/articles', params: {
        article: FactoryBot.attributes_for(:article)
      }

      expect(response).to have_http_status(:created)
    end

    it 'returns the correct content_type' do
      post '/api/v1/articles', params: {
        article: FactoryBot.attributes_for(:article)
      }

      expect(response.content_type).to eq('application/json; charset=utf-8')
    end
  end

  describe 'PATCH update' do
    context 'with valid parameters' do
      before do
        @article_update = FactoryBot.create(:article, title: 'Phasellus maximus elementum diam quis mollis.', active: true, category_id: 1)
      end

      it 'update a post' do
        patch '/api/v1/articles/1', params: {
          article: {
            title: 'Sed pretium rhoncus nibh a rhoncus.',
            active: true
            }
          }
        @article_update.reload
        expect(@article_update[:title]).to eq(FactoryBot.attributes_for(:article)[:title]) 
      end

      it 'returns the correct HTTP status' do
        patch '/api/v1/articles/1', params: {
          article: FactoryBot.attributes_for(:article)
        }
        expect(response).to have_http_status(:accepted)
      end

      it 'returns the correct content_type' do
        patch '/api/v1/articles/1', 
        params: { article: FactoryBot.attributes_for(:article)}
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
      
    end

    context 'published_at can not be changed' do
      before { @article_published_at = FactoryBot.create(:article, title: 'Phasellus maximus elementum diam quis mollis.', active: false, category_id: 1)}
      it 'update' do
        patch '/api/v1/articles/1', params: {
          article: {
            published_at: '20/12/2020 21:45'
            }
          }
        @article_published_at.reload
        expect(@article_published_at[:published_at]).to_not eq('20/12/2020 21:45')
      end
    end

    context 'with invalid parameters' do
      before do
        FactoryBot.create(:article, title: 'Sed pretium rhoncus nibh a rhoncus.', active: true, category_id: 1)
      end
      it 'renders a JSON response with errors' do
        patch '/api/v1/articles/1',
          params: { article: { title: nil, active: nil } }
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'DELETE destroy' do
    before do
      FactoryBot.create(:article, title: 'Sed pretium rhoncus nibh a rhoncus.', active: true, category_id: 1)
    end
    
    it 'destroys the requested article' do
      expect do
        delete '/api/v1/articles/1'
      end.to change(Article, :count).by(-1)
    end
  end

end
