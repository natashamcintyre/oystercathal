require_relative './journey.rb'

class Oystercard
  attr_reader :balance, :current_journey, :history
  LIMIT = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
    @history = []
  end

  def top_up(amount)
    raise "Balance cannot exceed #{LIMIT}" if @balance + amount > LIMIT

    @balance += amount
  end

  def touch_in(station)
    fail "Insufficient funds" if @balance < MIN_FARE

    @current_journey = Journey.new(station)
  end

  def in_journey?
    @current_journey != nil
  end

  def touch_out(exit_station)
    deduct(MIN_FARE)
    @current_journey.finish_journey(exit_station)
    @history << @current_journey
    @current_journey = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
