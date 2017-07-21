require 'rails_helper'

RSpec.describe StaticPlayer, type: :model do
	before do 		
		@static_player = FactoryGirl.create(:static_player)	
	end
	describe 'creation' do	
		it 'can be created without a team id' do
			@static_player.static_team_id = nil
			expect(@static_player).to_not be_valid
		end	
		it 'can not be created without a last name' do
			@static_player.last_name = nil
			expect(@static_player).to_not be_valid
		end
		it 'can not be created without a first name' do
			@static_player.first_name = nil
			expect(@static_player).to_not be_valid
		end
		it 'can not be created without a jersey number' do
			@static_player.jersey_number = nil
			expect(@static_player).to_not be_valid
		end
		it 'can not be created without a position' do
			@static_player.position = nil
			expect(@static_player).to_not be_valid
		end
		it 'can not be created without a height' do
			@static_player.height = nil
			expect(@static_player).to_not be_valid
		end
		it 'can not be created without a weight' do
			@static_player.weight = nil
			expect(@static_player).to_not be_valid
		end
		it 'can not be created without a birth date' do
			@static_player.birth_date = nil
			expect(@static_player).to_not be_valid
		end
		it 'can not be created without a age' do
			@static_player.age = nil
			expect(@static_player).to be_valid
		end
		it 'can not be created without a before_nba attr' do
			@static_player.before_nba = nil
			expect(@static_player).to_not be_valid
		end		
		it 'can not be created without a which_pick attr' do
			@static_player.which_pick = nil
			expect(@static_player).to_not be_valid
		end
		it 'can not be created without a years_pro attr' do
			@static_player.years_pro = nil
			expect(@static_player).to_not be_valid
		end
		it 'can not be created without a status' do
			@static_player.status = nil
			expect(@static_player).to_not be_valid
		end
	end

end
