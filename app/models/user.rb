require 'bcrypt'

class User < ActiveRecord::Base
  has_secure_password
  has_many :volunteer_commitments

  acts_as_messageable

  validates :username, presence: true
  validates_uniqueness_of :username, message: 'An account with that username already exists'
  validates_uniqueness_of :email, message: 'An account with that email address already exists'

  def signed_up_for shift
    return VolunteerCommitment.exists? user: self, shift: shift
  end

  def name
    self.username
  end

  def mailboxer_email object
    self.email

  end
end
