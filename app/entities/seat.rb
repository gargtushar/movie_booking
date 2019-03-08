class Seat 
  attr_accessor :name, :booked, :type 

  def initialize(name, type)
    self.name = name 
    self.type = type 
    self.booked = false  
  end 
  
  def book
    if self.booked
      return false 
    end
    self.booked = true 
    return true    
  end 
  
  def booking_status  
    # O -> Occupied, F -> Free 
    if self.booked
      return "O"
    else
      return "F"
    end   
  end  

end 