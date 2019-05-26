class Guest

  attr_reader :name, :wallet, :fav_song

  def initialize(name, wallet, fav_song)
    @name = name
    @wallet = wallet.to_f
    @fav_song = fav_song
  end

  def pay_for_something(charge)
    @wallet -= charge.to_f
  end

  def can_afford?(charge)
    @wallet >= charge.to_f
  end

end
