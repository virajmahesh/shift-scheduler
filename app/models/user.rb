class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :authentication_keys => [:login]

  has_many :volunteer_commitments

  has_many :user_skills
  has_many :skills, through: :user_skills

  acts_as_messageable

  validates :username, presence: true
  validates_uniqueness_of :username, message: 'An account with that username already exists'
  validates_uniqueness_of :email, message: 'An account with that email address already exists'

  attr_accessor :login

  def signed_up_for shift
    VolunteerCommitment.exists? user: self, shift: shift
  end

  def name
    self.username
  end

  def mailboxer_email object
    self.email
  end

  def self.find_first_by_auth_conditions conditions, opts = {}
    (User.find_by username: conditions[:login]) || (User.find_by email: conditions[:login])
  end
end
