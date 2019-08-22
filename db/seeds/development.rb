mizuho = Bank.create!({
  name: "ミズホ",
  code: Faker::Finance.credit_card
})

admin_user = AdminUser.create!({
  tel: Faker::PhoneNumber.unique.cell_phone,
  name: "admin_user",
  password: "password",
  email: Faker::Internet.unique.email
})

corporate_user = CorporateUser.create!({
  tel: Faker::PhoneNumber.unique.cell_phone,
  name: Faker::Name.last_name + "株式会社",
  password: "password",
  email: Faker::Internet.unique.email
})

personal_user_1 = PersonalUser.create!({
  tel: Faker::PhoneNumber.unique.cell_phone,
  name: Faker::Name.unique.name,
  password: "password",
  email: Faker::Internet.unique.email
})

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
  PersonalUser.create!({
    tel: Faker::PhoneNumber.unique.cell_phone,
    name: Faker::Name.unique.name,
    password: "password",
    email: Faker::Internet.unique.email
  })
end
