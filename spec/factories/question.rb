FactoryGirl.define do
  factory :question do
    sequence(:question_identifier) { |n| "q#{n}" }
    instrument
    text 'a'
  end
end
