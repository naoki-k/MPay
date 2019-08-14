FactoryBot.define do
  factory :billing do
    association :sender, factory: :user
    association :receiver, factory: :user
    amount { 1000 }
    content { "1000円の請求です。" }
  end
end
