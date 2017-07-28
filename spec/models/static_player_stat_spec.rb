require 'rails_helper'

RSpec.describe StaticPlayerStat, type: :model do
  before do
  	@static_player_stat = FactoryGirl.create(:static_player_stat)
  end
  describe 'creation' do
  	it 'cannot be created without a season' do
  	end
  	xit 'cannot be created without a team' do
  	end
  	xit 'cannot be created without games_played' do
  	end
  	xit 'cannot be created without games_started' do
  	end
  	xit 'cannot be created without minutes_per_game' do
  	end
  	xit 'cannot be created without field_goal_percent' do
  	end
  	xit 'cannot be created without three_point_percent' do
  	end
  	xit 'cannot be created without free_throw_percent' do
  	end
  	xit 'cannot be created without rebounds_per_game' do
  	end
  	xit 'cannot be created without assists_per_game' do
  	end
  	xit 'cannot be created without steals_per_game' do
  	end
  	xit 'cannot be created without blocks_per_game' do
  	end
  	xit 'cannot be created without points_per_game' do
  	end
  	xit 'cannot be created without a static_player id' do
  	end
  end
end
