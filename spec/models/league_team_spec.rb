require 'rails_helper'

RSpec.describe LeagueTeam, type: :model do
  before do
  	@league_team_one = create(:league_team_one)
  end
  describe 'creation' do
  	it 'can be created' do
  	  expect(@league_team_one).to be_valid
  	end
  	it 'cannot be created without a league_id' do
  		@league_team_one.league_id = nil
  		expect(@league_team_one).to_not be_valid
  	end
  	it 'cannot be created without a team_id' do
  		@league_team_one.team_id = nil
  		expect(@league_team_one).to_not be_valid
  	end
  	it 'cannot be duplicated' do
  		league_team_two = create(:league_team_two)
  		league_team_two.league_id = @league_team_one.league_id
  		league_team_two.team_id = @league_team_one.team_id
  		expect(league_team_two).to_not be_valid
  	end
  end
end
