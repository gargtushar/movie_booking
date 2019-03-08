class Problem
  attr_accessor :audies
  
  def initialize(show_count, seat_count)
   self.audies = Hash.new 
    (1..show_count).each do |sc|
       self.audies[sc] = Audi.new(sc, genrate_seats(seat_count))
    end 
  end

  def start 
  	entry = 1
  	while entry == 1 do
      display_seating_arrangement 
      process
      puts "Press 1 to book another"
      entry = gets.to_i
    end 
    Audi.final_revenue
  end  
  
  private 
   
    def genrate_seats(seat_count)
      seats = []
      Config.instance.data[:seat_types].each do |seat_type|
        (1..seat_count).each do |i|
          seat_name = (seat_type + i.to_s)
          seats << Seat.new(seat_name, seat_type) 
        end 	
      end 
      return seats
    end 
    
    def display_seating_arrangement
	    puts "Seating Arrangement:"
	    self.audies.each do |key, audi|
	      puts "Show #{audi.show} running in Audi#{key}"
	      puts "All Seats:"  
	      Config.instance.data[:seat_types].each do |seat_type| 
	        audi.seats.select{|k,v| v.type == seat_type }.each do |k, seat|
	          print "#{k} -> #{seat.booking_status}  "
	        end 
	        puts ''
	      end 
	    end
    end

    def process
      puts "Enter Show Number"
      show_number = gets.to_i 
      audi = self.audies.select{|k,v| v.show == show_number}.values.last
      if audi.blank? 
      	puts "Invalid show Number! Please Try again."
      	return
      end 
      puts "Enter Seats"
      seats = gets.strip
      audi.confirm_booking(seats.split(","))
    end
end 