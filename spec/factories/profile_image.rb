FactoryBot.define do
  factory :profile_image do
    image { File.open("spec/factories/images/admin_user.png").read }
    association :user
  end
end
