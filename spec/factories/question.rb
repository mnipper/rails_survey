FactoryGirl.define do
  factory :question do
    sequence(:question_identifier) { |n| "q#{n}" }
    sequence(:number_in_instrument) { |n| "#{n}" }
    instrument
    text 'a'
  end
end
