require 'rails_helper'

RSpec.describe StaticPlayerStat, type: :model do
  before do
  	@static_player_stat = FactoryGirl.create(:static_player_stat)
  end
  describe 'creation' do
  	it 'cannot be created without a season' do
  		@static_player_stat.season = nil
  		expect(@static_player_stat).to_not be_valid
  	end
  	it 'cannot be created without a team' do
  		@static_player_stat.team = nil
  		expect(@static_player_stat).to_not be_valid
  	end
  	it 'cannot be created without games_played' do
  		@static_player_stat.games_played = nil
  		expect(@static_player_stat).to_not be_valid
  	end
  	it 'cannot be created without games_started' do
  		@static_player_stat.games_started = nil
  		expect(@static_player_stat).to_not be_valid
  	end
  	it 'cannot be created without minutes_per_game' do
  		@static_player_stat.minutes_per_game = nil
  		expect(@static_player_stat).to_not be_valid
  	end
  	it 'cannot be created without field_goal_percent' do
  		@static_player_stat.field_goal_percent = nil
  		expect(@static_player_stat).to_not be_valid
  	end
  	it 'cannot be created without three_point_percent' do
  		@static_player_stat.three_point_percent = nil
  		expect(@static_player_stat).to_not be_valid
  	end
  	it 'cannot be created without free_throw_percent' do
  		@static_player_stat.free_throw_percent = nil
  		expect(@static_player_stat).to_not be_valid
  	end
  	it 'cannot be created without rebounds_per_game' do
  		@static_player_stat.rebounds_per_game = nil
  		expect(@static_player_stat).to_not be_valid
  	end
  	it 'cannot be created without assists_per_game' do
  		@static_player_stat.assists_per_game = nil
  		expect(@static_player_stat).to_not be_valid
  	end
  	it 'cannot be created without steals_per_game' do
  		@static_player_stat.steals_per_game = nil
  		expect(@static_player_stat).to_not be_valid
  	end
  	it 'cannot be created without blocks_per_game' do
  		@static_player_stat.blocks_per_game = nil
  		expect(@static_player_stat).to_not be_valid
  	end
  	it 'cannot be created without points_per_game' do
  		@static_player_stat.points_per_game = nil
  		expect(@static_player_stat).to_not be_valid
  	end
  	it 'cannot be created without a static_player id' do
  		@static_player_stat.static_player_id = nil
  		expect(@static_player_stat).to_not be_valid
  	end
  end
end
