FactoryGirl.define do
  factory :instrument do
    sequence(:title) {|n| "instrument #{n}" }
    language 'english'
    alignment 'left'
  end
end
