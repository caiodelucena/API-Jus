require 'rails_helper'

RSpec.describe Article, type: :model do
  before do
    FactoryBot.create(:category, name: 'Tecnologia', url: 'http://localhost:3000/api/v1/categories/1')
  end

  subject {
    Article.new(title: 'Sed pretium rhoncus nibh a rhoncus.', category_id: 1)
  }

  describe 'validations' do
    it 'is valid with title' do
      expect(subject).to be_valid
    end

    it 'is not valid without title' do
      article = Article.new(title: nil, category_id: 1)
      expect(article).to_not be_valid
    end
    
    context 'of category_id is not valid' do
      it 'without category_id' do
        article = Article.new(title: 'Sed pretium rhoncus nibh a rhoncus.')
        expect(article).to_not be_valid
      end

      it 'when Category does not exist' do
        article = Article.new(title: 'Sed pretium rhoncus nibh a rhoncus.', category_id: 4)
        expect(article).to_not be_valid
      end
    end


    context 'when title is not unique' do
      before { FactoryBot.create(:article,title: 'Sed pretium rhoncus nibh a rhoncus.', category_id: 1)}
      it { expect(subject).to be_invalid }
    end

    context 'when title is unique' do
      before { FactoryBot.create(:article, title: 'Phasellus maximus elementum diam quis mollis.', category_id: 1)}
      it { expect(subject).to be_valid }
    end

  end

  describe 'attribution' do
    context 'without status - DEFAULT STATUS' do
      before { @article_without_status = FactoryBot.create(:article, title: 'Phasellus maximus elementum diam quis mollis.', category_id: 1)}
      it { expect(@article_without_status[:active]).to be true }
    end

    context 'with inative status' do
      before { @article_with_status = FactoryBot.create(:article, title: 'Phasellus maximus elementum diam quis mollis.', active: false, category_id: 1)}
      it { expect(@article_with_status[:active]).to be false }
    end

    context 'published_at when article is created' do
      before { @article_published_at = FactoryBot.create(:article, title: 'Phasellus maximus elementum diam quis mollis.', active: false, category_id: 1)}
      it { expect(@article_published_at[:published_at].present?).to be true } 
    end 
    
  end

end