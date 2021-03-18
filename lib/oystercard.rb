class Oystercard
  attr_reader :balance, :maximum_balance, :travel_history, :current_journey
  MAXIMUM_BALANCE = 90
  INITIAL_BALANCE = 0
  MINIMUM_FARE = 1

  def initialize(maximum_balance = MAXIMUM_BALANCE, current_journey = Journey.new)
    @maximum_balance = maximum_balance
    @balance = INITIAL_BALANCE
    @current_journey = current_journey
    @travel_history = []
  end

  def top_up(value)
    raise "Cannot top up £#{value}. the maximum balance is £#{maximum_balance}" if balance_over_the_limit(value)

    @balance += value
  end


  def touch_in(station)
    raise 'Insufficient funds, Please toup your card' if insufficient_funds?
    @current_journey.entry_station = station
    @exit_station = nil
  end

  def touch_out(station)
    @current_journey.exit(station)
    deduct(current_journey.fare)
    create_journey
    @current_journey.entry_station = nil
  end

  def in_journey?
    current_journey.entry_station ? true : false
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

  def create_journey
    @travel_history.push(current_journey.dup)
  end

end
