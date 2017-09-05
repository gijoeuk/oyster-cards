class OysterCard

MAXIMUMBALANCE = 90
MINIMUMFAIR = 1

attr_reader :balance, :journey_start

  def initialize
    @balance = 0
    @journey_start = nil
  end

  def in_journey?
    @journey_start != nil
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
    @journey_start = station
  end

  def touch_out
    deduct(MINIMUMFAIR)
    @journey_start = nil
  end

  private :deduct

end
