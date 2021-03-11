class Oystercard
  attr_reader :balance, :maximum_balance, :entry_station, :travel_history
  MAXIMUM_BALANCE = 90
  INITIAL_BALANCE = 0
  MINIMUM_FARE = 1

  def initialize(maximum_balance = MAXIMUM_BALANCE)
    @maximum_balance = maximum_balance
    @balance = INITIAL_BALANCE
    @entry_station = nil
    @travel_history = []
  end

  def top_up(value)
    raise "Cannot top up £#{value}. the maximum balance is £#{maximum_balance}" if balance_over_the_limit(value)

    @balance += value
  end


  def touch_in(station)
    raise 'Insufficient funds, Please toup your card' if insufficient_funds?
    @entry_station = station
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    create_journey(entry_station, station)
    @entry_station = nil
  end

  def in_journey?
    entry_station ? true : false
  end

  private
  def deduct(fare)
    @balance -= fare
  end
  def balance_over_the_limit(value)
    @balance + value >= maximum_balance
  end

  def insufficient_funds?
    balance < MINIMUM_FARE
  end
  def create_journey(entry_station, exit_station)
    journey = { entry_station => exit_station }
    @travel_history.push(journey)
  end

end
