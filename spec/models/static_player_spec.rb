require 'rails_helper'

RSpec.describe StaticPlayer, type: :model do
	before do 		
		@static_player = FactoryGirl.create(:static_player)		
	end
	describe 'creation' do	
		it 'can be created without a team is' do
			@static_player.static_team_id = nil
			expect(@static_player).to be_valid
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
			expect(@static_player).to_not be_valid
		end
		it 'can not be created without a birth city' do
			@static_player.birth_city = nil
			expect(@static_player).to_not be_valid
		end
	end
end