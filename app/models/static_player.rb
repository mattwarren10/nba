
class StaticPlayer < ApplicationRecord
  extend MySportsApi
  belongs_to :static_team, optional: true

  attribute :nba_com, if: :nba_official_id_available?

  
  validates_presence_of :last_name, 
            						:first_name, 
            						:jersey_number, 
            						:position, 
            						:height, 
            						:weight, 
            						:birth_date, 
            						:age, 
            						:birth_city,
                        :nba_com
            
	def self.call_active_players_from_api
		send_request("2016-2017-regular", "active_players")
	end

  def nba_official_id_available?
    if data['player']['externalMapping'].nil?
      0
    else
      data['player']['externalMapping']['ID'].to_i
    end
  end
end
