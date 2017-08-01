FactoryGirl.define do
  factory :admin_user, class: "AdminUser" do
  	last_name "Warren"
  	first_name "Matt"
    username "mattwarren"
    email "mwarren@harding.edu"
    password "weeboo"
    password_confirmation "weeboo"    
  end

  factory :basic_user_one, class: "BasicUser" do
  	last_name "Mardanzai"
  	first_name "Louis"
    username "louismardanzai"
  	email "malwarr@indiana.edu"
  	password "tarbooz"
  	password_confirmation "tarbooz"
  end

  factory :basic_user_two, class: "BasicUser" do
    last_name "Jones"
    first_name "Alex"
    username "alexjones"
    email "alexjones@gmail.com"
    password "rockets"
    password_confirmation "rockets"

end
