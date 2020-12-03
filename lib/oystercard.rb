require_relative './journey.rb'

class Oystercard
  attr_reader :balance, :history, :current_journey

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

  def touch_in(station = nil)
    has_touched_out?
    fail "Insufficient funds" if @balance < MIN_FARE

    @current_journey = Journey.new(station)
  end

  def in_journey?
    @current_journey != nil
  end

  def touch_out(exit_station = nil)
    has_touched_in?
    @current_journey.finish_journey(exit_station)
    deduct_fare
    @history << @current_journey
    @current_journey = nil
  end

  def has_touched_in?
      @current_journey = Journey.new if @current_journey == nil
  end

  def has_touched_out?
    touch_out if @current_journey != nil #new
  end

  private

  def deduct_fare
    @balance -= @current_journey.fare
  end
end
