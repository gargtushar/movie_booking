class Tax 
  attr_accessor :name, :percentage

  def initialize( name, percentage)
    self.name = name 
    self.percentage = percentage
  end 

  def calculate_tax_amount(amount)
    (amount * self.percentage)/100
  end 

end 