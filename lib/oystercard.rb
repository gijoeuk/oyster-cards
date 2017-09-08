require_relative 'journey'

class OysterCard

MAXIMUMBALANCE = 90
MINIMUMFAIR = 1
attr_reader :balance, :journey_history, :journey_start, :journey

  def initialize
    @balance = 0
    @journey_history = Hash.new
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
    @journey = Journey.new(station)
    @journey_start = station
    @journey_history.store(:entry_station, station)
  end

  def touch_out(station)
    deduct(MINIMUMFAIR)
    @journey.touch_out
    @journey_history.store(:exit_station, station)
  end
  private :deduct
end
