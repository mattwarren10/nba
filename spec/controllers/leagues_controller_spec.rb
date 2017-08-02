require 'rails_helper'

RSpec.describe LeaguesController, type: :controller do
	describe 'accessing Leagues' do
		it 'requires login' do
			get :index
			expect(response).to redirect_to new_user_session
		end
	end
end
