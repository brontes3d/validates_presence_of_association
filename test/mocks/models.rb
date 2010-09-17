class Car < ActiveRecord::Base
  belongs_to :driver
  validates_presence_of_association :driver
  
end

class Driver < ActiveRecord::Base
  has_many :cars
  
end