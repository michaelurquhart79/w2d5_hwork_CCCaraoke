class Guest

  attr_reader :name, :wallet, :fav_song
  attr_accessor :spend_tracker

  def initialize(name, wallet, fav_song)
    @name = name
    @wallet = wallet.to_f
    @fav_song = fav_song
    @spend_tracker = {}
  end

  def pay_for_something(charge)
    @wallet -= charge.to_f
  end

  def can_afford?(charge)
    @wallet >= (current_spend + charge.to_f)
  end

  def add_to_spend_tracker(item, cost)
    @spend_tracker[item] = cost.to_f
  end

  def current_spend
    if @spend_tracker != {}
      return @spend_tracker.values.sum
    else
      return 0.to_f
    end
  end

end
