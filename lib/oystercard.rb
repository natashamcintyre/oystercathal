require_relative './journey.rb'

class Oystercard
  attr_reader :balance, :entry, :history
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

  def touch_in(entry)
    fail "Insufficient funds" if @balance < MIN_FARE
    @entry = entry
  end

  def in_journey?
    @entry
  end

  def touch_out(exit_station)
    deduct(MIN_FARE)
    @history << { :entry => @entry, :exit => exit_station }
    @entry = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
