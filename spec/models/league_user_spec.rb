require 'rails_helper'

RSpec.describe LeagueUser, type: :model do
  before do
  	@league_basic_user_one = create(:league_basic_user_one)
  end
  describe 'creation' do
  	it 'can be created' do
  		expect(@league_basic_user_one).to be_valid
  	end
  	it 'cannot be created without a league_id' do
  		@league_basic_user_one.league_id = nil
  		expect(@league_basic_user_one).to_not be_valid
  	end
  	it 'cannot be created without a user_id' do
  		@league_basic_user_one.user_id = nil
  		expect(@league_basic_user_one).to_not be_valid
  	end
  	it 'cannot be duplicated' do
  		league_basic_user_two = create(:league_basic_user_two)
  		league_basic_user_two.league_id = @league_basic_user_one.league_id
  		league_basic_user_two.user_id = @league_basic_user_one.user_id
  		expect(league_basic_user_two).to_not be_valid
  	end
  end
end
