require 'rails_helper'

RSpec.describe Stat, type: :model do
	describe 'creation' do
		before do								
			@stat = create(:stat)
		end
		it 'cannot be created without a season' do
			@stat.season = nil
			expect(@stat).to_not be_valid
		end
		it 'cannot be created without a team' do
			@stat.team = nil
			expect(@stat).to_not be_valid
		end
		it 'cannot be created without games_played' do
			@stat.games_played = nil
			expect(@stat).to_not be_valid
		end
		# games started wasn't recorded until 1981-82 season
		it 'cannot be created without games_started' do
			@stat.games_started = nil
			expect(@stat).to_not be_valid
		end
		it 'cannot be created without minutes_per_game' do
			@stat.minutes_per_game = nil
			expect(@stat).to_not be_valid
		end
		it 'cannot be created without field_goal_percent' do
			@stat.field_goal_percent = nil
			expect(@stat).to_not be_valid
		end
		# three pointers weren't recorded until 1979-80 season
		it 'cannot be created without three_point_percent' do
			@stat.three_point_percent = nil
			expect(@stat).to_not be_valid
		end
		it 'cannot be created without free_throw_percent' do
			@stat.free_throw_percent = nil
			expect(@stat).to_not be_valid
		end
		it 'cannot be created without rebounds_per_game' do
			@stat.rebounds_per_game = nil
			expect(@stat).to_not be_valid
		end
		it 'cannot be created without assists_per_game' do
			@stat.assists_per_game = nil
			expect(@stat).to_not be_valid
		end
		# steals and blocks weren't recorded until 1973-74 season
		it 'cannot be created without steals_per_game' do
			@stat.steals_per_game = nil
			expect(@stat).to_not be_valid
		end
		it 'cannot be created without blocks_per_game' do
			@stat.blocks_per_game = nil
			expect(@stat).to_not be_valid
		end
		it 'cannot be created without points_per_game' do
			@stat.points_per_game = nil
			expect(@stat).to_not be_valid
		end
	end

	describe 'enums' do
		let(:level) { [:pro, :college, :international, :high_school] }
		let(:category) { [:authentic, :fantasy] }

		it '(level) has the right index' do
			level.each_with_index do |item, index|
				expect(described_class.levels[item]).to eq(index)
			end	
		end
		it '(category) has the right index' do
			category.each_with_index do |item, index|
				expect(described_class.categories[item]).to eq(index)
			end	
		end
	end
end
