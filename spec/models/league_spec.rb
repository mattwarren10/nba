require 'rails_helper'

RSpec.describe League, type: :model do
  before do
  	@league_nba = create(:league_nba)
  end
  describe 'creation' do
  	it 'can be created' do
  		expect(@league_nba).to be_valid
  	end
  end

  describe 'presence of attributes' do
  	it 'cannot be created without a name' do
  		@league_nba.name = nil
  		expect(@league_nba).to_not be_valid
  	end
  	it 'cannot be created without a commissioner' do
  		@league_nba.commissioner = nil
  		expect(@league_nba).to_not be_valid
  	end
  	it 'cannot be created without a headquarters' do
  		@league_nba.headquarters = nil
  		expect(@league_nba).to_not be_valid
  	end
  	it 'cannot be created without an inaugural season' do
  		@league_nba.inaugural_season = nil
  		expect(@league_nba).to_not be_valid
  	end
  	it 'cannot be created without a number_of_teams' do
  		@league_nba.number_of_teams = nil
  		expect(@league_nba).to_not be_valid
  	end
  	it 'cannot be created without an abbreviation' do
  		@league_nba.abbreviation = nil
  		expect(@league_nba).to_not be_valid
  	end
  end

  describe 'uniquness' do
    before do 
      @league_fantasy_one = create(:league_fantasy_one)
      @league_fantasy_two = create(:league_fantasy_two)      
    end
    it 'can have the same name as another league if users are different' do                 
      @league_fantasy_two.name = @league_fantasy_one.name
      expect(@league_fantasy_two).to be_valid
    end

    # These might need to be in the controller
    it 'can have multiple users' do
      @league_fantasy_one.users.push(@league_fantasy_two.users.first)
      expect(@league_fantasy_one).to be_valid
    end
    it 'cannot have the same name as another league of the same user' do            
      @league_fantasy_two.users.push(@league_fantasy_one.users.first)      
      @league_fantasy_two.commissioner = @league_fantasy_one.commissioner
      @league_fantasy_two.name = @league_fantasy_one.name
      expect(@league_fantasy_two).to_not be_valid
    end
    xit 'cannot have basic users whose commissioner is an admin user' do
      @league_nba = create(:league_nba)
      @league_nba.commissioner = @league_nba.users.first.username
      @league_nba.users.push(@league_fantasy_one.users.first)
      expect(@league_nba).to_not be_valid
    end
  end

end
