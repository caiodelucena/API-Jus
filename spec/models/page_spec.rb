require 'rails_helper'

RSpec.describe Article, type: :model do
  before do
    FactoryBot.create(:category, name: 'Tecnologia', url: 'http://localhost:3000/api/v1/categories/1')
    FactoryBot.create(:article, title: 'Sed pretium rhoncus nibh a rhoncus.', active: true, category_id: 1)
    FactoryBot.create(:article, title: 'Phasellus maximus elementum diam quis mollis.', active: true, category_id: 1)
  end

  subject {
    Page.new(content: 'Sed pretium rhoncus nibh a rhoncus. Proin hendrerit tellus', article_id: 1)
  }

  describe 'validations' do
    it 'is valid with content' do
      expect(subject).to be_valid
    end

    it 'is not valid without the content' do
      page = Page.new(content: nil, article_id: 1)
      expect(page).to_not be_valid
    end
    
    context 'of article_id is not valid' do

      it 'when article_id already exist' do
        page = FactoryBot.create(:page, content: 'Sed pretium rhoncus nibh a rhoncus. Proin hendrerit tellus', article_id: 1)
        expect(subject).to_not be_valid
      end

      it 'without article_id' do
        page = Page.new(content: 'Sed pretium rhoncus nibh a rhoncus. Proin hendrerit tellus')
        expect(page).to_not be_valid
      end

      it 'when Article does not exist' do
        page = Page.new(content: 'Sed pretium rhoncus nibh a rhoncus. Proin hendrerit tellus', article_id: 3)
        expect(page).to_not be_valid
      end

    end


    context 'when content is not unique' do
      before { FactoryBot.create(:page, content: 'Sed pretium rhoncus nibh a rhoncus. Proin hendrerit tellus', article_id: 1)}
      it { expect(subject).to be_invalid }
    end

    context 'when content is unique' do
      before { FactoryBot.create(:page, content: 'Sed pretium rhoncus nibh a rhonhendrerit tellus', article_id: 2)}
      it { expect(subject).to be_valid }
    end

  end

  describe 'attribution' do
    context 'number of pages' do
      before { @page = FactoryBot.create(:page, content: 'Sed pretium rhoncus nibh a rhoncus. Proin hendrerit tellus', article_id: 1)}
      it { expect(@page[:number].present?).to be true }
    end

  end

end