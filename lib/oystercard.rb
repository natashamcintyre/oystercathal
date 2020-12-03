require_relative './journey.rb'

class Oystercard
  attr_reader :balance, :history
  attr_accessor :current_journey
  LIMIT = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
    @history = []
    @current_journey = nil
  end

  def top_up(amount)
    raise "Balance cannot exceed #{LIMIT}" if @balance + amount > LIMIT

    @balance += amount
  end

  def touch_in(station = nil)
    touch_out if @current_journey != nil #new
    fail "Insufficient funds" if @balance < MIN_FARE

    @current_journey = Journey.new(station)
  end

  def in_journey?
    @current_journey != nil
  end

  def touch_out(exit_station = nil)
    has_touched_in?
    @current_journey.finish_journey(exit_station)
    deduct(@current_journey.fare)
    @history << @current_journey
    @current_journey = nil
  end

  def has_touched_in?
      @current_journey = Journey.new if @current_journey == nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
