require 'singleton'

class Config 
  include Singleton 
  
  attr_accessor :data 

  def initialize
    @data = {
      "A": 320,
      "B": 280,
      "C": 240, 
      "D": 500,
      "seat_types": ["A","B", "C", "D"], 
      "tax_types": { 
        "service_tax": 14.0, 
        "swachh_bharat_cess": 0.5, 
        "krishi_kalyan_cess": 0.5
      }
    }
  end 
end 
