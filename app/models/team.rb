class Team < ApplicationRecord
	has_many :players

	# validates :city, presence: true, uniquenss: true
	# validates :name, presence: true, uniquenss: true
	# validates :abbreviation, presence: true, uniquenss: true
end
