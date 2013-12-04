FactoryGirl.define do
  factory :question do
    sequence(:question_identifier) { |n| "q#{n}" }
  end
end
