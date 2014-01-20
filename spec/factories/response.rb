FactoryGirl.define do
  factory :response do
    question
    survey
    text 'a'
    special_response 'SKIP'
    other_response 'other'
  end

end
