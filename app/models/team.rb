class Team < ApplicationRecord
	extend MySportsApi

	has_many :players

	validates :city, presence: true, uniqueness: true
	validates :name, presence: true, uniqueness: true
	validates :abbreviation, presence: true, uniqueness: true

	def self.
		send_request("2016-2017-regular", "overall_team_standings")
	end
end
