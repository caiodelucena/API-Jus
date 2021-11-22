class Category < ApplicationRecord
  before_save :set_url

  validates :name, uniqueness: { case_sensitive: false }, presence: true


  private

  def set_url
    if self.new_record? && Category.count > 0
      @last_id_category = Category.last.id
      self.url = "http://localhost:3000/api/v1/categories/#{@last_id_category + 1}"
    else
      self.url = "http://localhost:3000/api/v1/categories/#{1}"
    end
  end
end