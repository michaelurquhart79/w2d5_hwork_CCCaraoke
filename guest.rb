class Guest

  attr_reader :name, :wallet

  def initialize(name, wallet)
    @name = name
    @wallet = wallet.to_f
  end

  def pay_for_something(charge)
    @wallet -= charge.to_f
  end

  def can_afford?(charge)
    @wallet >= charge.to_f
  end

end
