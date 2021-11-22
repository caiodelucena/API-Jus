class Category < ApplicationRecord
  has_many :articles

  before_save :set_url

  validates :name, uniqueness: { case_sensitive: false }, presence: true


  private

  def set_url
    if self.new_record?
      if Category.all.present?
        @last_id_category = Category.last.id
        self.url = "http://localhost:3000/api/v1/categories/#{@last_id_category + 1}"
      else
        self.url = "http://localhost:3000/api/v1/categories/#{1}"
      end
    end
  end
end