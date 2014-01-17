FactoryGirl.define do
  factory :instrument do
    sequence(:title) {|n| "instrument #{n}" }
    language 'en'
    alignment 'left'
    project
  end
end
