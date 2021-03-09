class Oystercard
  attr_reader :balance, :maximum_balance
  MAXIMUM_BALANCE = 90

  def initialize(maximum_balance = MAXIMUM_BALANCE)
    @maximum_balance = maximum_balance
    @balance = 0
  end

  def top_up(value)
    raise "Cannot top up £#{value}. the maximum balance is £#{maximum_balance}" if balance_over_the_limit(value)

    @balance += value
  end

  private
  def balance_over_the_limit(value)
    @balance + value >= maximum_balance
  end

end
