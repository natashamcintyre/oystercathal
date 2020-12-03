class Journey

  attr_reader :entry_station, :exit_station

  PENALTY_FARE = 6

  def initialize(station)
    @entry_station = station
  end

  def finish_journey(station)
    @exit_station = station
  end

  def fare
    PENALTY_FARE
  end

end
