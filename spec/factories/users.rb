FactoryBot.define do
  factory :user do
    sequence(:tel, 012011110000) {|n| "user#{n}" }
    sequence(:name) {|n| "user#{n}"}
  end

  factory :admin_user, parent: :user do
    type { "AdminUser" }
  end

  factory :corporate_user, parent: :user do
    type { "CorporateUser" }
  end

  factory :personal_user, parent: :user do
    type { "PersonalUser" }
  end
end
