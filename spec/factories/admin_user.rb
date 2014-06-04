FactoryGirl.define do 
  factory :admin_user do
    email 'admin@example.com'
    password 'Password1'
    password_confirmation 'Password1'
  end
end
