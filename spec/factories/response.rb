FactoryGirl.define do
  factory :response do
    question
    survey_uuid '00000000-0000-0000-0000-000000000000'
    text 'a'
    other_response 'other'
  end
end
