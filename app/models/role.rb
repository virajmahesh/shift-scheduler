class Role < ActiveRecord::Base
    belongs_to :user
    belongs_to :shift
    
    validates :description, presence: true
end
