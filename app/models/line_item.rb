class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  belongs_to :cart

  def total_price
    product.price * quantity
  end

  def decrement_quantity
    if quantity > 1
      quantity -= 1
    end
  end
end
