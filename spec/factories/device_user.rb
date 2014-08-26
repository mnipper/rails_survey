FactoryGirl.define do 
  factory :device_user do
    name 'Test User 1'
    username 'testuser1'
    password 'Password1'
    password_confirmation 'Password1'
    active true
  end
end
