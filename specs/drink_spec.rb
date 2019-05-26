require('minitest/autorun')
require('minitest/rg')
require_relative('../drink')


class TestDrink < Minitest::Test

  def setup
    @drink1 = Drink.new("Beer", 3.95)
    @drink2 = Drink.new("Gin", 4.50)
  end

  def test_drink_has_name
    assert_equal("Beer", @drink1.name)
  end

  def test_drink_has_price
    assert_equal(4.5, @drink2.price)
  end

end
