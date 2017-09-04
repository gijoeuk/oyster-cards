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

  def pay_fare(fare)
    if (@balance - fare) >= 0
      @balance - fare
    else
      fail "You broke"
    end
  end
end
