class OysterCard

MAXIMUMBALANCE = 90
MINIMUMFAIR = 1

attr_reader :balance, :in_journey, :journey_start

  def initialize
    @balance = 0
    @in_journey =  false
    @journey_start = nil
  end

  def top_up(amount)
    raise "The maximum balance has already been reached" if (balance + amount) > MAXIMUMBALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in(station)
    raise "Insufficient funds" if @balance < MINIMUMFAIR
    @in_journey = true
    @journey_start = station
  end

  def touch_out
    @in_journey = false
    deduct(MINIMUMFAIR)
    @journey_start = nil
  end

  private :deduct

end
