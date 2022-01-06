class Oystercard
  attr_reader :balance
  attr_reader :entry_station


MAXIMUM_BALANCE = 90 
MINIMUM_BALANCE = 1
MINIMUM_FARE = 3

  def initialize
    @balance = 0
    @journey_status = false
  end

  def top_up(num)
    fail 'You have reached your balance limit' if num + balance > MAXIMUM_BALANCE
    @balance += num
  end

  def in_journey?
    !!entry_station

  end

def touch_in(station)
  fail 'not enough money' if @balance < MINIMUM_BALANCE
  @entry_station = station
end

def touch_out
  deduct(MINIMUM_FARE)
  @entry_station = nil
end

private 

def deduct(fare)
  @balance -= fare
end


end