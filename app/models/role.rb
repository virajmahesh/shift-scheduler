class Role < ActiveRecord::Base
    validates :description, presence: true
end
