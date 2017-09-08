class Journey
  attr_reader :in_journey, :journey_start
  def initialize(station)
    @in_journey = true
    @journey_start = station
  end

  def touch_out
    @in_journey = false
  end
end
