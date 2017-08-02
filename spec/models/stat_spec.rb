require 'rails_helper'

RSpec.describe Stat, type: :model do
	describe 'creation' do
		before do								
			@stat = FactoryGirl.create(:stat)
		end
		it 'cannot be created without games played' do
			@stat.games_player = nil
			expect(@stat).to_not be_valid
		end
	end
end
