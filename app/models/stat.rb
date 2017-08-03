class Stat < ApplicationRecord

  enum category: { authentic: 0, fantasy: 1 }

  belongs_to :league_player, optional: true
  belongs_to :league_team
end
