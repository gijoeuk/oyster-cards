class OysterCard

attr_reader :balance, :in_journey

  def initialize
    @balance = 0
    @in_journey =  false
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

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end
end
