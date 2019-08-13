FactoryBot.define do
  factory :corporate_information do
    association :corporate_user
    address { "茨城県つくば市" }
    detail { "科学の町、つくば。いつもきれい。すごい。" }
  end
end
