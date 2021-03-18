class Journey
  attr_reader :entry_station, :exit_station
  PENALTY_FARE = 6
  MINIMUM_FARE = 1

  def initialize(entry_station: nil)
    @entry_station = entry_station
    @complete = false
    @exit_station = nil
  end

  def complete?
    @complete
  end

  def fare
    exit_station ? MINIMUM_FARE : PENALTY_FARE
  end

  def exit(station = nil)
    @exit_station = station
    @complete = true
    self
  end

end
