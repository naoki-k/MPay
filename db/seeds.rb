mizuho = Bank.create!({
  name: "ミズホ",
  code: "123-45"
})

admin_user = AdminUser.create!({
  tel: "000-0000-0000",
  name: "admin_user",
  password: "password",
  email: "admin_user@example.com"
})

corporate_user = CorporateUser.create!({
  tel: "100-0000-0000",
  name: "corporate_user",
  password: "password",
  email: "corporate_user@example.com"
})

personal_user_1 = PersonalUser.create!({
  tel: "000-0000-0001",
  name: "personal_user_1",
  password: "password",
  email: "personal_user_1@example.com"
})

personal_user_1.bank_payments.create!({
  bank: mizuho,
  number: "200-0000-0002",
  is_active: true
})

personal_user_2 = PersonalUser.create!({
  tel: "200-0000-0002",
  name: "personal_user_2",
  password: "password",
  email: "personal_user_2@example.com"
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
