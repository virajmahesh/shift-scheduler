class UserActivity < ActiveRecord::Base
    belongs_to :user
    belongs_to :shift
    belongs_to :event
    
    def href
        raise "You must instantiate subclass of UserActivity"
    end
    
    def representation
        raise "You must instantiate subclass of UserActivity"
    end
        
    
end