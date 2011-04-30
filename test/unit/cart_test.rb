require 'test_helper'

class CartTest < ActiveSupport::TestCase
  def setup
    @cart = Cart.create
    @book_one = products(:ruby)
    @book_two = products(:two)
  end

  test "should add unique products" do
    @cart.add_product(@book_one.id).save!
    @cart.add_product(@book_two.id).save!
    assert_equal 2, @cart.line_items.size
    assert_equal @book_one.price + @book_two.price, @cart.total_price
  end

  test "should add duplicate products" do
    @cart.add_product(@book_one.id).save!
    @cart.add_product(@book_one.id).save!
    assert_equal 1, @cart.line_items.size, "duplicate product shouldn't bump size"
    assert_equal 2 * @book_one.price, @cart.total_price
    assert_equal 2, @cart.line_items[0].quantity, "quantity screwedUp"
  end
end
