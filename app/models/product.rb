class Product < ActiveRecord::Base
  default_scope :order => 'title' 
  has_many :line_items
  has_many :orders, :through => :line_items
  before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, :description, :image_url, :presence => true
  validates :title, :uniqueness => true
  validates_length_of :title, :minimum => 10, :message => "Title too short - should be at least 10 chars long"

  validates :price, :numericality => { :greater_than_or_equal_to => 0.01 }
  validates :price, :numericality => { :less_than_or_equal_to => 150.00 }

  validates :image_url, :format => {
    :with => %r{\.(gif|jpg|png)$}i,
    :message => "must be a URL for GIF, JPG or PNG image."
  }
  validates :image_url, :uniqueness => true

private
  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, 'Line items present')
      return false
    end
  end

end
