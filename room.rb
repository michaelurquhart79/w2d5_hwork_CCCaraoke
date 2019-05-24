

class Room


  attr_reader :name, :guest_list, :song_list, :capacity, :entry_fee, :till

  def initialize(name, capacity, till)
    @name = name
    @capacity = capacity
    @guest_list = []
    @song_list = []
    @entry_fee = 6.00
    @till = till.to_f

  end

  def add_guest(guest)
    if @guest_list.length < @capacity
      if guest.can_afford?(@entry_fee)
        @guest_list << guest
        guest.pay_for_something(@entry_fee)
        @till += entry_fee
      else
        return "Sorry, not enough money to get in #{guest.name}"
      end
    else
      return "Sorry #{guest.name}, this room is full. You cannot enter."
    end
  end

  def add_song(song)
    @song_list << song
  end

  def remove_guest(guest)
    @guest_list.delete(guest)
  end


end
