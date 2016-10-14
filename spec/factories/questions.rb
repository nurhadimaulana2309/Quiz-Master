FactoryGirl.define do
  factory :question do
    content { FFaker::Lorem.sentence }
    answer  { FFaker::Address.city }
  end
end