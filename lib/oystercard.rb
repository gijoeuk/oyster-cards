class OysterCard

attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    if (@balance + amount) <= 90
      @balance += amount
    else
      fail "The maximum balance has already been reached"
    end
  end

  def deduct(amount)
    if (@balance - amount) >= 0
      @balance - amount
    else
      fail "You broke"
    end
  end
end
