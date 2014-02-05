FactoryGirl.define do
  factory :survey do
    instrument
    instrument_title 'Instrument title'
    instrument_version_number '1'
    device
    sequence(:device_uuid) { |n| "00000000-0000-0000-0000-00000000000#{n}" }
    sequence(:uuid) { |n| "00000000-0000-0000-0000-00000000000#{n}" }
  end
end
