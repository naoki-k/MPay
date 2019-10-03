# 手動テスト用データ

admin_user = AdminUser.create!({
  tel: Faker::PhoneNumber.unique.cell_phone,
  name: "admin_user",
  password: "password",
  email: "admin1@example.com"
})
admin_user.credit_payment.update_attribute(:is_active, true)
admin_user.account_activation.update_attribute(:activated, true)

test_user_1 = PersonalUser.create!({
  tel: Faker::PhoneNumber.unique.cell_phone,
  name: "テスト 一郎",
  password: "password",
  email: "test1@example.com"
})

test_user_2 = PersonalUser.create!({
  tel: Faker::PhoneNumber.unique.cell_phone,
  name: "テスト 次郎",
  password: "password",
  email: "test2@example.com"
})

[test_user_1, test_user_2].each_with_index do |user, i|
  user.credit_payment.update_attribute(:is_active, true)
  user.update_attribute(:code, i)
  user.account_activation.update_attribute(:activated, true)
  Trade.create!({
    active_payment: admin_user.credit_payment,
    passive_payment: user.credit_payment,
    amount: 10000
  })
end

corporate_user_1 = CorporateUser.create!({
  tel: Faker::PhoneNumber.unique.cell_phone,
  name: Faker::Name.last_name + "株式会社",
  password: "password",
  email: "corporate1@example.com"
})
corporate_user_1.account_activation.update_attribute(:activated, true)
corporate_user_1.credit_payment.update_attribute(:is_active, true)

# ---------------

mizuho = Bank.create!({
  name: "ミズホ",
  code: Faker::Finance.credit_card
})

corporate_user = CorporateUser.create!({
  tel: Faker::PhoneNumber.unique.cell_phone,
  name: Faker::Name.last_name + "株式会社",
  password: "password",
  email: Faker::Internet.unique.email
})
corporate_user.credit_payment.update_attribute(:is_active, true)

personal_user_1 = PersonalUser.create!({
  tel: Faker::PhoneNumber.unique.cell_phone,
  name: Faker::Name.unique.name,
  password: "password",
  email: Faker::Internet.unique.email
})
personal_user_1.credit_payment.update_attribute(:is_active, true)

personal_user_1.bank_payments.create!({
  bank: mizuho,
  number: Faker::PhoneNumber.unique.cell_phone,
  is_active: true
})

personal_user_2 = PersonalUser.create!({
  tel: Faker::PhoneNumber.unique.cell_phone,
  name: Faker::Name.unique.name,
  password: "password",
  email: Faker::Internet.unique.email
})
personal_user_2.credit_payment.update_attribute(:is_active, true)

Trade.create!({
  active_payment: admin_user.credit_payment,
  passive_payment: personal_user_1.credit_payment,
  amount: 10000
})

Trade.create!({
  active_payment: admin_user.credit_payment,
  passive_payment: personal_user_2.credit_payment,
  amount: 10000
})

Trade.create!({
  active_payment: personal_user_1.bank_payments.first,
  passive_payment: personal_user_1.credit_payment,
  amount: 3000
})

Trade.create!({
  active_payment: personal_user_1.credit_payment,
  passive_payment: personal_user_2.credit_payment,
  amount: 3000
})

Trade.create!({
  active_payment: personal_user_1.credit_payment,
  passive_payment: corporate_user.credit_payment,
  amount: 3000
})

30.times do
  CorporateUser.create!({
    tel: Faker::PhoneNumber.unique.cell_phone,
    name: Faker::Name.last_name + "株式会社",
    password: "password",
    email: Faker::Internet.unique.email
  })
  user = PersonalUser.create!({
    tel: Faker::PhoneNumber.unique.cell_phone,
    name: Faker::Name.unique.name,
    password: "password",
    email: Faker::Internet.unique.email
  })

  user.follow(test_user_1)
end
