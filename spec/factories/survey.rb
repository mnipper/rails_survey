FactoryGirl.define do
  factory :survey do
    instrument
    instrument_version_number '1'
    device
    sequence(:uuid) { |n| "00000000-0000-0000-0000-00000000000#{n}" }
  end
end
