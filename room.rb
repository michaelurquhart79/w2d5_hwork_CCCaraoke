

class Room


  attr_reader :name, :guest_list, :song_list, :capacity, :entry_fee, :till, :drinks

  def initialize(name, capacity, till, drinks)
    @name = name
    @capacity = capacity
    @guest_list = []
    @song_list = []
    @entry_fee = 6.00
    @till = till.to_f
    @drinks = drinks

  end

  def add_guest(guest)
    if @guest_list.length < @capacity
      if guest.can_afford?(@entry_fee)
        @guest_list << guest
        guest.add_to_spend_tracker("Admission", @entry_fee)
        # @till += entry_fee
      else
        return "Sorry, not enough money to get in #{guest.name}"
      end
    else
      return "Sorry #{guest.name}, this room is full. You cannot enter."
    end
  end

  def sell_drink(guest, drink)
    if guest.can_afford?(drink.price)
      guest.add_to_spend_tracker(drink.name, drink.price)
      # @till += entry_fee
    else
      return "Sorry, not enough money for that drink #{guest.name}"
    end
  end

  def add_song(song)
    @song_list << song
  end

  def remove_guest(guest)
    @guest_list.delete(guest)
    @till += guest.current_spend
    guest.pay_for_something(guest.current_spend)
    guest.spend_tracker = {}
  end

  def fav_song_in_list(guest)
    @song_list.each do |song|
      if song.name == guest.fav_song
        return "#{guest.name} says: Whoo!"
      end
    end
    return "#{guest.name} says: Boo!"
  end


end
