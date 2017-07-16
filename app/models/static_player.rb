
class StaticPlayer < ApplicationRecord
  extend MySportsApi
  belongs_to :static_team
  
  validates_presence_of :last_name, 
            						:first_name, 
            						:jersey_number, 
            						:position, 
            						:height, 
            						:weight, 
            						:birth_date, 
            						# :age, to be rendered in views to grab current time a user visits the page
            						:before_nba
            
	def self.call_active_players_from_api
		send_request("2016-2017-regular", "active_players")
	end

end
