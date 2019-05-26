require('minitest/autorun')
require('minitest/rg')
require('pry')
require_relative('../guest')
require_relative('../song')
require_relative('../room')
require_relative('../drink')


class TestRoom < Minitest::Test

  def setup
    @guest1 = Guest.new("Mike",100, "Get Free")
    @guest2 = Guest.new("Dave", 50, "Hey Hey My My")
    @guest3 = Guest.new("Bullhelm",10, "Wannabe")
    @guest4 = Guest.new("Shakki", 10, "Chop Suey")
    @guest5 = Guest.new("Scott", 5, "Limmasol")
    @song1 = Song.new("Hey Jude")
    @song2 = Song.new("Get Free")
    @song3 = Song.new("Wannabe")
    @drink1 = Drink.new("Beer", 3.95)
    @drink2 = Drink.new("Gin", 4.50)
    @drink3 = Drink.new("Wine", 4.00)
    @drink4 = Drink.new("Vodka", 4.50)
    @drinks = [@drink1, @drink2, @drink3, @drink4]
    @room1 = Room.new("Jimi Hendrix Room", 3, 100, @drinks)

  end

  def test_room_has_name
    assert_equal("Jimi Hendrix Room",@room1.name)
  end

  def test_room_guest_list_initially_empty
    assert_equal(0, @room1.guest_list.length)
  end

  def test_room_song_list_initially_empty
    assert_equal(0, @room1.song_list.length)
  end

  def test_add_guest_to_room
    @room1.add_guest(@guest1)
    assert_equal(@guest1, @room1.guest_list[0])
  end


  def test_add_song_to_room
    @room1.add_song(@song1)
    assert_equal(@song1, @room1.song_list[0])
  end

  def test_remove_guest__guest1_remains
    @room1.add_guest(@guest1)
    @room1.add_guest(@guest2)
    @room1.remove_guest(@guest2)
    assert_equal(@guest1, @room1.guest_list[0])
  end

  def test_remove_guest__guest2_remains
    @room1.add_guest(@guest1)
    @room1.add_guest(@guest2)
    @room1.remove_guest(@guest1)
    assert_equal(@guest2 , @room1.guest_list[0])
  end

  def test_room_has_capacity
    assert_equal(3, @room1.capacity)
  end

  def test_add_guest_to_room__room_is_full
    @room1.add_guest(@guest1)
    @room1.add_guest(@guest2)
    @room1.add_guest(@guest3)
    result = @room1.add_guest(@guest4)
    assert_equal(3, @room1.guest_list.length)
    assert_equal("Sorry Shakki, this room is full. You cannot enter.", result)
    assert_equal(6.0, @guest1.current_spend)
    assert_equal(10.0, @guest4.wallet)

  end

  def test_room_has_entry_fee
    assert_equal(6.0,@room1.entry_fee)
  end

  def test_add_guest_to_room__can_afford
    @room1.add_guest(@guest1)

    assert_equal(@guest1, @room1.guest_list[0])
    assert_equal(6.0,@guest1.current_spend)
    assert_equal(100.0, @room1.till)
  end

  def test_add_guest_to_room__cannot_afford
    result = @room1.add_guest(@guest5)
    assert_equal(0, @room1.guest_list.length)
    assert_equal("Sorry, not enough money to get in Scott", result)
    assert_equal(5.0, @guest5.wallet)
    assert_equal(100.0, @room1.till)
  end

  def test_room_has_till
    assert_equal(100.0, @room1.till)
  end

  def test_fav_song_in_list__in_list
    @room1.add_song(@song1)
    @room1.add_song(@song2)
    @room1.add_song(@song3)
    result = @room1.fav_song_in_list(@guest1)
    assert_equal("Mike says: Whoo!", result)
  end

  def test_fav_song_in_list__not_in_list
    @room1.add_song(@song1)
    @room1.add_song(@song2)
    @room1.add_song(@song3)
    result = @room1.fav_song_in_list(@guest2)
    assert_equal("Dave says: Boo!", result)
  end

  def test_room_has_drinks
    assert_equal(4, @room1.drinks.length)
  end

  def test_sell_drink
    @room1.sell_drink(@guest1, @drink1)
    assert_equal(3.95, @guest1.current_spend)
  end

  def test_sell_drink__cant_afford
    @room1.add_guest(@guest4)
    result = @room1.sell_drink(@guest4,@drink4)
    assert_equal("Sorry, not enough money for that drink Shakki",result)
  end

  def test_remove_guest__bill_payment_check
    @room1.add_guest(@guest1)
    # binding.pry
    @room1.add_guest(@guest2)
    @room1.sell_drink(@guest1,@drink2)
    @room1.sell_drink(@guest1,@drink3)
    @room1.sell_drink(@guest1,@drink4)
    @room1.remove_guest(@guest1)
    assert_equal(81.0,@guest1.wallet)
    assert_equal(119.0,@room1.till)
  end

end
