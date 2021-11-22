class Page < ApplicationRecord
  belongs_to :article

  before_save :set_number_pages

  validates :content, uniqueness: { case_sensitive: false }, presence: true
  validates :article_id, uniqueness: true

  private

  def set_number_pages
    self.number = (self.content.size / 8000.0).ceil if self.new_record?
  end

end