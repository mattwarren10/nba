require 'rails_helper'

RSpec.describe Team, type: :model do
	before do 
		@team = create(:team)
	end
	describe 'team creation' do
		it 'will not be created when city is empty' do
			@team.city = nil
			expect(@team).to_not be_valid
		end
		it 'will not be created when name is empty' do
			@team.name = nil
			expect(@team).to_not be_valid
		end
		it 'will not be created when abbreviation is empty' do
			@team.abbreviation = nil
			expect(@team).to_not be_valid
		end
	end

	describe 'team uniqueness' do
		it 'cannot be a duplicate of another team' do
			team_duplicate = build_stubbed(:team_duplicate)
			team_duplicate.name = @team.name
			expect(team_duplicate).to_not be_valid
		end
	end
end