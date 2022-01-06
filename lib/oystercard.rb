class Oystercard
  attr_reader :balance
  attr_reader :entry_station
  attr_reader :journeys
  attr_reader :exit_station


MAXIMUM_BALANCE = 90 
MINIMUM_BALANCE = 1
MINIMUM_FARE = 3

  def initialize
    @balance = 0
    @journeys = []
    @entry_station = entry_station
    @exit_station = exit_station
  end

  def top_up(num)
    fail 'You have reached your balance limit' if num + balance > MAXIMUM_BALANCE
    @balance += num
  end

  def in_journey?
    !!entry_station

  end

def touch_in!(station)
  fail 'not enough money' if @balance < MINIMUM_BALANCE
  @entry_station = station
  @journeys << {start: station}
end

def touch_out!(station)
  deduct(MINIMUM_FARE)
  #@entry_station = nil
  @exit_station = station
  @journeys.last[:finish] = station
end

private 

def deduct(fare)
  @balance -= fare
end


end