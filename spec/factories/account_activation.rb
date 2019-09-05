FactoryBot.define do
  factory :account_activation do
    association :user
    activated { false }
  end
end
