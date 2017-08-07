class User < ApplicationRecord
  attr_accessor :login

  has_many :league_users
  has_many :leagues, through: :league_users
  has_many :league_teams
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i
  USERNAME_REGEX = /^[a-zA-Z0-9_\.]*$/        

  validates :email, :presence => true,
  					:format => EMAIL_REGEX
  validates :username, :presence => true,
            :format => { :with => USERNAME_REGEX,
                         :multiline => true
                       },
            :uniqueness => { :case_sensitive => false }
  validate :validate_username
  validates :last_name, :presence => true
  validates :first_name, :presence => true
  validates_length_of :leagues, maximum: 5


  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", 
                                                       { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  # a user cannot have the same username as the email of another
  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

  def full_name
    self.first_name + ", " + self.last_name
  end
end
