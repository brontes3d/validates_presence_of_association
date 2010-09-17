ActiveRecord::Schema.define do

  create_table "cars", :force => true do |t|
    t.integer  "driver_id"
    t.string   "name"
  end

  create_table "drivers", :force => true do |t|
    t.string   "name"
  end

end