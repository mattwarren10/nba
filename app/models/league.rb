class League < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :league_teams
  has_many :teams, through: :league_teams
  has_many :league_players
  has_many :players, through: :league_players

  validates_presence_of :name,
  						:commissioner,
  						:headquarters,
  						:inaugural_season,
  						:number_of_teams,
  						:abbreviation

  validates_uniqueness_of :name, if: :unique_name?

  # forbids a user to create a league of the same name if they are the commissioner
  def unique_name?
  	n = self.name
  	c = self.commissioner
  	self.users.each do |user|
  		user.leagues.each do |league|
  			if c = league.commissioner
  				true if n != league.name
  			end
  		end
  	end
  end
end
