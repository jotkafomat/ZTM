class Oystercard
  attr_reader :balance, :maximum_balance
  MAXIMUM_BALANCE = 90
  INITIAL_BALANCE = 0
  MINIMUM_FARE = 1

  def initialize(maximum_balance = MAXIMUM_BALANCE)
    @maximum_balance = maximum_balance
    @balance = INITIAL_BALANCE
    @in_journey = false
  end

  def top_up(value)
    raise "Cannot top up £#{value}. the maximum balance is £#{maximum_balance}" if balance_over_the_limit(value)

    @balance += value
  end

  def deduct(fare)
    @balance -= fare
  end

  def touch_in
    raise 'Insufficient funds, Please toup your card' if insufficient_funds?
    @in_journey = !@in_journey
  end

  def touch_out
    @in_journey = !@in_journey
  end

  def in_journey?
    @in_journey
  end

  private
  def balance_over_the_limit(value)
    @balance + value >= maximum_balance
  end

  def insufficient_funds?
    balance < MINIMUM_FARE
  end

end
