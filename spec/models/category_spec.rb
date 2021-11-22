require 'rails_helper'

RSpec.describe Category, type: :model do
  subject {
    Category.new(name: 'Tecnologia')
  }

  describe 'validations' do
    it 'is valid with name' do
      expect(subject).to be_valid
    end

    it 'is not valid without name' do
      category = Category.new(name: nil)
      expect(category).to_not be_valid
    end

    context 'when name is not unique' do
      before { Category.create!(name: 'TecnOlOgIa')}
      it { expect(subject).to be_invalid }
    end

    context 'when name is unique' do
      before { Category.create!(name: 'Direito')}
      it { expect(subject).to be_valid }
    end

  end

end