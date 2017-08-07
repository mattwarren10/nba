class League < ApplicationRecord
  has_many :league_users
  has_many :users, through: :league_users
  has_many :league_teams
  has_many :teams, through: :league_teams
  has_many :league_players
  has_many :players, through: :league_players

  validates_presence_of :name,
            						:commissioner,
            						:headquarters,
            						:inaugural_season,
            						:number_of_teams,
            						:abbreviation,
                        :users

  validates_uniqueness_of :name, scope: [ :commissioner ]             


end
