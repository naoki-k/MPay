FactoryBot.define do
  factory :billing do
    association :sender
    association :receiver
    amount { 1000 }
    content { "1000円の請求です。" }
  end
end
