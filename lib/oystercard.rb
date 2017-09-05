class OysterCard

attr_accessor :balance, :in_journey

  def initialize
    @balance = 0
    @in_journey =  false
  end

  def top_up(amount)
    raise "The maximum balance has already been reached" if (@balance + amount) >= 90
    @balance += amount
  end

  def deduct(amount)
      @balance -= amount
  end

  def touch_in
    raise "Insufficient funds" if @balance < 1
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end
end
