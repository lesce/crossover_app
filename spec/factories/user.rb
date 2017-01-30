FactoryGirl.define do
  factory :user do
    first_name "John"
    last_name  "Doe"
    sequence :email do |n|
      "test#{n}@test.com"
    end
    password "password"
  end

  # This will use the User class (Admin would have been guessed)
  factory :admin, class: User do
    first_name "Admin"
    last_name  "User"
    email "admin@test.com"
    password "password"
    role User::ADMIN_ROLE
  end
end
