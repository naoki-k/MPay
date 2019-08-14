FactoryBot.define do
  factory :trade do
    association :active_payment, factory: :payment
    association :passive_payment, factory: :payment
    amount { 1000 }

    trait :qr do
      kind { "qr" }
    end
  end
end
