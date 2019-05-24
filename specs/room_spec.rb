require('minitest/autorun')
require('minitest/rg')
require('pry')
require_relative('../guest')
require_relative('../song')
require_relative('../room')



class TestRoom < Minitest::Test

  def setup
    @room1 = Room.new("Jimi Hendrix Room", 3, 100)
    @guest1 = Guest.new("Mike",100)
    @guest2 = Guest.new("Dave", 50)
    @guest3 = Guest.new("Bullhelm",10)
    @guest4 = Guest.new("Shakki", 10)
    @guest5 = Guest.new("Scott", 5)
    @song1 = Song.new("Hey Jude")
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
    assert_equal(94.0, @guest1.wallet)
    assert_equal(10.0, @guest4.wallet)

  end

  def test_room_has_entry_fee
    assert_equal(6.0,@room1.entry_fee)
  end

  def test_add_guest_to_room__can_afford
    @room1.add_guest(@guest1)

    assert_equal(@guest1, @room1.guest_list[0])
    assert_equal(94.0,@guest1.wallet)
    assert_equal(106.0, @room1.till)
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
end
