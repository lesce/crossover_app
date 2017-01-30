FactoryGirl.define do
  factory :ticket do
    title "Test"
    content "lorem ipsum"
    user
  end
end
