FactoryBot.define do
  factory :payment do
    number { SecureRandom.alphanumeric(16) }
    is_active { true }
    association :user
  end

  factory :credit_payment, parent: :payment, class: "CreditPayment" do
    type { "CreditPayment" }

    trait :inactive do
      is_active { false }
    end
  end

  factory :bank_payment, parent: :payment, class: "BankPayment" do
    association :bank
    type { "BankPayment" }

    trait :inactive do
      is_active { false }
    end
  end
end
