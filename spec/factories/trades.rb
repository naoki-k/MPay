FactoryBot.define do
  factory :trade do
    association :active_payment
    association :passive_payment
    amount { 1000 }

    trait :qr do
      kind { "qr" }
    end
  end
end
