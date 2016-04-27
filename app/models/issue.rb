class Issue < ActiveRecord::Base
    validates :description, presence: true
end
