FactoryGirl.define do
  factory :instrument_translation do
    instrument
    language 'sw'
    title 'translated title'
    alignment 'left'
  end
end
