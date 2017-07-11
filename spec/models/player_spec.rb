require 'rails_helper'

RSpec.describe Player, type: :model do
	before do 		
		@player = FactoryGirl.create(:player)		
	end
	describe 'creation' do		
		it 'can not be created without a last name' do
			@player.last_name = nil
			expect(@player).to_not be_valid
		end
		it 'can not be created without a first name' do
			@player.first_name = nil
			expect(@player).to_not be_valid
		end
		it 'can not be created without a jersey number' do
			@player.jersey_number = nil
			expect(@player).to_not be_valid
		end
		it 'can not be created without a position' do
			@player.position = nil
			expect(@player).to_not be_valid
		end
		it 'can not be created without a height' do
			@player.height = nil
			expect(@player).to_not be_valid
		end
		it 'can not be created without a weight' do
			@player.weight = nil
			expect(@player).to_not be_valid
		end
		it 'can not be created without a birth date' do
			@player.birth_date = nil
			expect(@player).to_not be_valid
		end
		it 'can not be created without a age' do
			@player.age = nil
			expect(@player).to_not be_valid
		end
		it 'can not be created without a birth city' do
			@player.birth_city = nil
			expect(@player).to_not be_valid
		end
	end
end