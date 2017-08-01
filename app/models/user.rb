class User < ApplicationRecord
  has_and_belongs_to_many :leagues
  has_many :league_teams
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i         

  validates :email, :presence => true,
  					:format => EMAIL_REGEX
  
  validates_presence_of	:last_name,
  						:first_name,
  						:username

  validates_uniqueness_of :username


end
