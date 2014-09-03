FactoryGirl.define do
  factory :response do
    question
    survey
    text 'a'
    special_response 'SKIP'
    other_response 'other'
    sequence(:question_identifier) {|n| "q_#{n}" } 
    device_user
    question_version 1
    time_started "12:23"
    time_ended "12:24"
  end
end
