class Stat < ApplicationRecord

  enum level: { pro: 0, college: 1 }
  enum category: { authentic: 0, fantasy: 1 }

  belongs_to :league_player, optional: true
  belongs_to :league_team, optional: true

  SEASON_REGEX = /\d\d\d\d\-(\d\d|\d\d\d\d)/

  # the next two validations says an active player's stat can be without a team or a league
  validates :league_player, presence: true, unless: :team_exist?  
  validates :league_team, presence: true, unless: :player_exist?
  validates :season, presence: true, 
            :length => { minimum: 7, maximum: 9 },
            :format => SEASON_REGEX
  validates_presence_of :team,
            						:games_played,  						
            						:minutes_per_game,
            						:field_goal_percent,  						
            						:free_throw_percent,
            						:rebounds_per_game,
            						:assists_per_game,  						  						
            						:points_per_game

  validates :games_started, presence: true, if: :active_player? || :team_exist?
  validates :three_point_percent, presence: true, if: :active_player? || :team_exist?
  validates :steals_per_game, presence: true, if: :active_player? || :team_exist?
  validates :blocks_per_game, presence: true, if: :active_player? || :team_exist?

  def team_exist?
    league_team = LeagueTeam.find(self.league_team_id) rescue nil
    if league_team.nil?
      false
    elsif Team.find(league_team.team_id)
      true
    end
  end

  def player_exist?
    league_player = LeaguePlayer.find(self.league_player_id) rescue nil
    if league_player.nil?
      false
    elsif Player.find(league_player.player_id)
      true
    end
  end

  def active_player?
    league_player = LeaguePlayer.find(self.league_player_id) rescue nil
  	if league_player.nil?      
  		false
    elsif Player.find(league_player.player_id).status == "active"
      true
  	end
  end
  
end
