class Journey

  attr_reader :entry_station, :exit_station


  def initialize(station)
    @entry_station = station
  end

  def finish_journey(station)
    @exit_station = station
  end
end
