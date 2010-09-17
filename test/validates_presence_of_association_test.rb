require 'test/unit'

require 'rubygems'
require 'activerecord'

#set rails env CONSTANT (we are not actually loading rails in this test, but activerecord depends on this constant)
RAILS_ENV = 'test' unless defined?(RAILS_ENV)

#setup active record to use a sqlite database
# ActiveRecord::Base.configurations = {"test"=>{"dbfile"=>"test.db", "adapter"=>"sqlite3"}}
# ActiveRecord::Base.establish_connection
ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :dbfile => ":memory:")

#load the database schema for this test
load File.expand_path(File.dirname(__FILE__) + "/mocks/schema.rb")

#require this plugin
require "#{File.dirname(__FILE__)}/../init"

#require the mock models for the voting system
require File.expand_path(File.dirname(__FILE__) + '/mocks/models.rb')

class ValidatesPresenceOfAssociationTest < Test::Unit::TestCase
  
  def test_validates_presence_of_association
    car = Car.new
    driver = Driver.new
    
    #should fail because neither driver or driver_id is set
    assert_raises(ActiveRecord::RecordInvalid){ car.save! }

    #should pass because driver is set (driver_id is not)
    car.driver = driver
    assert car.save!
    
    #should pass becuase driver_id is set (driver is not)
    Car.class_eval do
      def driver
        nil
      end
    end
    assert Car.find(car.id).save!
  end
  
end
