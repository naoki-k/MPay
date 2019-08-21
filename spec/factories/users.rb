FactoryBot.define do
  factory :user do
    sequence(:tel, 012011110000) {|n| "user#{n}" }
    sequence(:name) {|n| "user#{n}"}
    sequence(:email) {|n| "user#{n}@example.com"}
    password { "password" }

    trait :with_confirmation do
      password_confirmation { "password" }
    end
  end

  factory :admin_user, parent: :user, class: "AdminUser" do
    type { "AdminUser" }
  end

  factory :corporate_user, parent: :user, class: "CorporateUser" do
    type { "CorporateUser" }
  end

  factory :personal_user, parent: :user, class: "PersonalUser" do
    type { "PersonalUser" }
  end
end
