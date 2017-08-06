require 'rails_helper'

RSpec.describe LeaguePlayer, type: :model do
  before do 
  	@league_player_one = create(:league_player_one)
  end
  describe 'creation' do
  	it 'can be created' do
  		expect(@league_player_one).to be_valid
  	end
  	it 'cannot be created without a league_id' do
  		@league_player_one.league_id = nil
  		expect(@league_player_one).to_not be_valid
  	end
  	it 'cannot be created without a player_id' do
  		@league_player_one.player_id = nil
  		expect(@league_player_one).to_not be_valid
  	end
  	it 'can be created without a league_team_id' do
  		@league_player_one.league_team_id = nil
  		expect(@league_player_one).to be_valid
  	end  	
  	it 'cannot be duplicated' do  		
  		league_player_two = create(:league_player_two)
      league_player_two.league_id = @league_player_one.league_id
      league_player_two.player_id = @league_player_one.player_id
  		expect(league_player_two).to_not be_valid
  	end
  end
  describe 'associations' do


  end

end
