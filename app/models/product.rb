class Product < ActiveRecord::Base
  validates :title, :description, :image_url, :presence => true
  validates :price, :numericality => { :greater_than_or_equal_to => 0.01 }
  validates :title, :uniqueness => true
  validates_length_of :title, :minimum => 10, :message => "Title too short - should be at least 10 chars long"
  validates :image_url, :format => {
    :with => %r{\.(gif|jpg|png)$}i,
    :message => "must be a URL for GIF, JPG or PNG image."
  }
end
