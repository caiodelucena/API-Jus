class Article < ApplicationRecord
  belongs_to :category
  
  attr_readonly :published_at
  
  before_save :set_time_published, :set_default_status

  validates :title, uniqueness: { case_sensitive: false }, presence: true

  private

  def set_default_status
    self.active = true if self.new_record? && (self.active != false)
  end

  def set_time_published
    self.published_at = Time.now.strftime("%d/%m/%Y %H:%M") if self.new_record?
  end
end