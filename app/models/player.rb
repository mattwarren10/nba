
class Player < ApplicationRecord  
  enum status: { active: 0, retired: 1 }

  has_many :league_players
  has_many :leagues, through: :league_players

  validates_presence_of :last_name, 
            						:first_name, 
            						:jersey_number, 
            						:position, 
            						:height, 
            						:weight, 
            						:birth_date, 
            						:which_pick,
                        :years_pro,
            						:before_nba,
                        :wiki_link,                      
                        :status
end
