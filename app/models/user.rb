require 'bcrypt'

class User < ActiveRecord::Base
  has_secure_password
  has_many :volunteer_commitments

  validates :username, presence: true
  validates_uniqueness_of :username, message: 'An account with that username already exists'
  validates_uniqueness_of :email, message: 'An account with that email address already exists'

  def signed_up_for shift
    return VolunteerCommitment.exists? user: self, shift: shift
  end
end
