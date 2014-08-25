FactoryGirl.define do
  factory :response do
    question
    survey
    text 'a'
    special_response 'SKIP'
    other_response 'other'
    sequence(:question_identifier) {|n| "q_#{n}" } 
    device_user
  end
end
