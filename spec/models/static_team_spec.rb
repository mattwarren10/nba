require 'rails_helper'

RSpec.describe StaticTeam, type: :model do
	before do 
		@static_team = FactoryGirl.create(:static_team)
	end
	describe 'static_team creation' do
		it 'will not be created when city is empty' do
			@static_team.city = nil
			expect(@static_team).to_not be_valid
		end
		it 'will not be created when name is empty' do
			@static_team.name = nil
			expect(@static_team).to_not be_valid
		end
		it 'will not be created when abbreviation is empty' do
			@static_team.abbreviation = nil
			expect(@static_team).to_not be_valid
		end
	end

	describe 'static_team uniqueness' do
		it 'cannot be a duplicate of another static_team' do
			@static_team_duplicate = FactoryGirl.build_stubbed(:static_team_duplicate)
			expect(@static_team_duplicate).to_not be_valid
		end
	end
end