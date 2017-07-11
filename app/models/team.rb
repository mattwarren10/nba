class Team < ApplicationRecord
	has_many :players

	validates :city, presence: true, uniqueness: true
	validates :name, presence: true, uniqueness: true
	validates :abbreviation, presence: true, uniqueness: true
end
