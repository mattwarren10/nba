class Stat < ApplicationRecord
  belongs_to :league_player
  belongs_to :league_team
end
