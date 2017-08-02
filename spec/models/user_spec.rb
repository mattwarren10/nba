require 'rails_helper'

RSpec.describe User, type: :model do
  before do 
  	@basic_user_one = FactoryGirl.create(:basic_user_one)
  end

  describe 'creation' do
  	it 'can be created' do
  		expect(@basic_user_one).to be_valid
  	end  	
  end

  describe 'email' do
  	it 'cannot be the wrong format' do
  		@basic_user_one.email = 'aa@a'
  		expect(@basic_user_one).to_not be_valid
  	end
  end

  describe 'custome name methods' do
    it 'has a full name method that combines last name and first name' do
      expect(@basic_user_one.full_name).to eq("Louis, Mardanzai")
    end
  end

  describe 'presence of attributes' do
  	it 'cannot be created without an email' do
  		@basic_user_one.email = nil
  		expect(@basic_user_one).to_not be_valid 
  	end
  	it 'cannot be created without a last_name' do
  		@basic_user_one.last_name = nil
  		expect(@basic_user_one).to_not be_valid 
  	end
  	it 'cannot be created without a first_name' do
  		@basic_user_one.first_name = nil
  		expect(@basic_user_one).to_not be_valid 
  	end
  	it 'cannot be created without a last_name' do
  		@basic_user_one.username = nil
  		expect(@basic_user_one).to_not be_valid 
  	end
  end

  describe 'uniqueness' do
  	it 'cannot have a duplicate username' do
  		@basic_user_two = FactoryGirl.create(:basic_user_two)
  		@basic_user_two.username = 'louismardanzai'
  		expect(@basic_user_two).to_not be_valid
  	end  	
  end

# These might need to be in the controller spec
  describe 'leagues' do
    before do
      @league_fantasy_two = FactoryGirl.create(:league_fantasy_two)
    end
    it 'can have multiple leagues' do            
      @basic_user_one.leagues.push(@league_fantasy_two)
      expect(@basic_user_one).to be_valid
    end
    it 'cannot have more than 10 leagues' do 
      11.times { @basic_user_one.leagues.push(@league_fantasy_two)}
      expect(@basic_user_one).to_not be_valid
    end
    xit 'cannot have basic users whose commissioner is an admin user' do
      @league_nba = FactoryGirl.create(:league_nba)
      @league_nba.commissioner = @league_nba.users.first.username
      @league_nba.users.push(@basic_user_one)
      expect(@league_nba).to_not be_valid
    end
  end
end
