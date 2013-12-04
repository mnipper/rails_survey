FactoryGirl.define do
  factory :option_translation do
    option
    language 'sw'
    text 'translated text'
  end
end
