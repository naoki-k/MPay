FactoryBot.define do
  factory :payment do
    number { SecureRandom.alphanumeric(16) }
    is_active { true }
    association :user
  end

  factory :credit_payment, parent: :payment do
    type { "CreditPayment" }

    trait :inactive do
      is_active { false }
    end
  end

  factory :bank_payment, parent: :payment do
    type { "BankPayment" }

    trait :inactive do
      is_active { false }
    end
  end
end
