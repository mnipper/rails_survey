FactoryGirl.define do
  factory :question_translation do
    question
    language 'sw'
    text 'translated text'
  end
end
