
class Player < ApplicationRecord
  extend MySportsApi
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

            
	def self.call_active_players_from_api
		send_request("2016-2017-regular", "active_players")
	end

end
