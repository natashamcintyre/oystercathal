class Journey

  attr_accessor :entry_station, :exit_station

  PENALTY_FARE = 6
  MINIMUM_FARE = 1

  def initialize(station = nil)
    @entry_station = station
  end

  def finish_journey(station)
    @exit_station = station
  end

  def fare
    complete_journey? ? MINIMUM_FARE : PENALTY_FARE
  end

  def complete_journey?
    @entry_station != nil && @exit_station != nil
  end

end
