class OysterCard

MAXIMUMBALANCE = 90
MINIMUMFAIR = 1

attr_reader :balance, :journey_history, :journeys, :journey_start

  def initialize
    @balance = 0
    @journey_start = nil
    @journey_history = []
    @journeys = Hash.new
  end

  def in_journey?
    !!@journey_start 
  end

  def top_up(amount)
    raise "The maximum balance has already been reached" if (balance + amount) > MAXIMUMBALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in(station)
    raise "Insufficient funds" if balance < MINIMUMFAIR
    @journey_start = station
    @journey_history << station
  end

  def touch_out(station)
    deduct(MINIMUMFAIR)
    @journey_start = nil
    @journey_history << station
    #@journeys < journey_history.pop(2).map { |a,b| a=>key, b=>value}
  end

  private :deduct

end
