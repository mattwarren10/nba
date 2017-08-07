FactoryGirl.define do
  sequence :username do |n|
    "username#{n}"
  end
  sequence :email do |n|
    "test#{n}@test.com"
  end
  factory :admin_user, class: "AdminUser" do
  	last_name "Warren"
  	first_name "Matt"
    username { generate :username }
    email { generate :email }
    password "weeboo"
    password_confirmation "weeboo"    
  end

  factory :basic_user_one, class: "BasicUser" do
  	last_name "Mardanzai"
  	first_name "Louis"
    username { generate :username }
  	email { generate :email }
  	password "tarbooz"
  	password_confirmation "tarbooz"
  end

  factory :basic_user_two, class: "BasicUser" do
    last_name "Jones"
    first_name "Alex"
    username { generate :username }
    email { generate :email }
    password "rockets"
    password_confirmation "rockets"
  end

  factory :basic_user_three, class: "BasicUser" do
    last_name "Smith"
    first_name "John"
    username { generate :username }
    email { generate :email }
    password "pacers"
    password_confirmation "pacers"
  end
end
