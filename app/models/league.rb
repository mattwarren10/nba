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

  validates_uniqueness_of :name, scope: [ :commissioner ]


end
