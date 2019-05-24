require('minitest/autorun')
require('minitest/rg')
require_relative('../guest')

class TestGuest < Minitest::Test

  def setup
    @guest1 = Guest.new("Mike", 1000)
  end

  def test_guest_has_a_name
    assert_equal("Mike",@guest1.name)
  end

  def test_guest_has_money
    assert_equal(1000.0, @guest1.wallet)
  end

  def test_pay_for_something
    @guest1.pay_for_something(100)
    assert_equal(900.0, @guest1.wallet)
  end

  def test_can_afford__true
    result = @guest1.can_afford?(100)
    assert(result)
  end

  def test_can_afford__false
    result = @guest1.can_afford?(10000)
    refute(result)
  end


end
