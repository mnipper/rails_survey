FactoryGirl.define do
  factory :device do
    sequence(:identifier) {|n| "device_#{n}" }
  end
end
