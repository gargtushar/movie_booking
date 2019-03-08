require 'active_support'
require 'byebug'

ActiveSupport::Dependencies.autoload_paths = [
  'app/',
  'app/entities',
  'config/'
]

no_of_shows = 3 
seat_count = 9  # avaialbe seat count in every group A, B or C. 

create_hall = Problem.new(no_of_shows, seat_count)
create_hall.start

