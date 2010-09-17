ActiveRecord::Base.class_eval do
  
  def self.validates_presence_of_association(*args)
    args.each do |assoc|
      reflected_assoc = reflect_on_association(assoc)
      validate do |record|
        if record.send(reflected_assoc.primary_key_name.to_sym).blank? and record.send(reflected_assoc.name.to_sym).blank?
          record.errors.add(reflected_assoc.name.to_sym, "association can't be blank")
        end
      end
    end
  end
  
end