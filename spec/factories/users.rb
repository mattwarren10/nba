FactoryGirl.define do
  factory :admin_user, class: "AdminUser" do
  	last_name "Warren"
  	first_name "Matt"
    email "mwarren@harding.edu"
    password "weeboo"
    password_confirmation "weeboo"    
  end

  factory :basic_user, class: "BasicUser" do
  	last_name "Mardanzai"
  	first_name "Louis"
  	email "malwarr@indiana.edu"
  	password "tarbooz"
  	password_confirmation "tarbooz"
  end
end
