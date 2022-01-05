class Oystercard
  attr_reader :balance

MAXIMUM_BALANCE = 90 


  def initialize
    @balance = 0
    @journey_status = false
  end

  def top_up(num)
    fail 'You have reached your balance limit' if num + balance > MAXIMUM_BALANCE
    @balance += num
  end

  def deduct(fare)
    @balance -= fare
  end

  def in_journey?
    @journey_status
  end

def touch_in
  fail 'insufficent balance' if @balance < 1 
  @journey_status = true
  
end

def touch_out
  @journey_status = false
end


end