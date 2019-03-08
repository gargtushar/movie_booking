class Audi
  attr_accessor :show, :seats, :taxes 
  @@revenue = 0
  @@taxes

  
  def initialize(show = 1, seats=[])
    self.show = show 
    self.seats = Hash.new
    seats.each do |seat|
      self.seats[seat.name] = seat 
    end 
    self.taxes = []
    Config.instance.data[:tax_types].each {|k,v| self.taxes << Tax.new(k,v) }
    @@taxes = self.taxes
  end 	
  
  def confirm_booking(seats)
  	subtotal = 0
    seats.each do |seat|
      target_seat = self.seats[seat]
      if target_seat.blank? 
        puts "Error! Wrong Seat Name"
        puts "Try Again"
        return 
      end 
      if target_seat.booking_status == "O"
        puts "#{seat} Not available, Please select different seats"
        return  
      end
      target_seat.book
      subtotal = subtotal + Config.instance.data[:"#{target_seat.type}"] 
    end
    
    puts "Successfully Booked Show#{self.show}"
    puts "subtotal: Rs.#{subtotal.to_s}"
    total = subtotal
    self.taxes.each do |tax|
      tax_amount = tax.calculate_tax_amount(subtotal)
      puts "#{tax.name} @#{tax.percentage}% : Rs.#{tax_amount.round(2).to_s}"
      total = total + tax_amount
    end   
    puts "Total: Rs. #{total.round(2).to_s}"
    @@revenue = @@revenue + subtotal
  end 
  

  def self.final_revenue
    puts "Total Revenue: Rs.#{@@revenue.to_s}"
    @@taxes.each do |tax|
      tax_amount = tax.calculate_tax_amount(@@revenue)
      puts "#{tax.name} @#{tax.percentage}% : Rs.#{tax_amount.round(2).to_s}"
    end 
  end

  def seat_validity(seat)
    !self.seats[seat].blank?
  end
  

  private 

  # def calculate_additional_charges(subtotal, percentage)
  #   return ((subtotal * percentage)/100)
  # end 
  
end 