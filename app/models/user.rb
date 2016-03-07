require 'bcrypt'

class User < ActiveRecord::Base
  has_secure_password

  validates :username, presence: true
  validates_uniqueness_of :username, message: 'An account with that username already exists'
  validates_uniqueness_of :email, message: 'An account with that email address already exists'
end
