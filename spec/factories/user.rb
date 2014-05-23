FactoryGirl.define do 
  factory :user do
    email 'user@example.com'
    password 'password'
    password_confirmation 'password'
    id 0
    roles ['admin']
  end
end
