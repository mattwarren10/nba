require 'rails_helper'

RSpec.describe User, type: :model do
  before do 
  	@basic_user = FactoryGirl.create(:basic_user_one)
  end

  describe 'creation' do
  	it 'can be created' do
  		expect(@basic_user).to be_valid
  	end  	
  end

  describe 'email' do
  	it 'cannot be the wrong format' do
  		@basic_user.email = 'aa@a'
  		expect(@basic_user).to_not be_valid
  	end
  end

  describe 'presence of attributes' do
  	it 'cannot be created without an email' do
  		@basic_user.email = nil
  		expect(@basic_user).to_not be_valid 
  	end
  	it 'cannot be created without a last_name' do
  		@basic_user.last_name = nil
  		expect(@basic_user).to_not be_valid 
  	end
  	it 'cannot be created without a first_name' do
  		@basic_user.first_name = nil
  		expect(@basic_user).to_not be_valid 
  	end
  	it 'cannot be created without a last_name' do
  		@basic_user.username = nil
  		expect(@basic_user).to_not be_valid 
  	end
  end

  describe 'uniqueness' do
  	it 'cannot have a duplicate username' do
  		@basic_user_two = FactoryGirl.create(:basic_user_two)
  		@basic_user_two.username = 'louismardanzai'
  		expect(@basic_user_two).to_not be_valid
  	end  	
  end
end
