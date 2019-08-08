admin_user = AdminUser.create!({
  tel: "000-0000-0000",
  name: "admin_user",
  payments_attributes: [
    {
      kind: "credit",
      number: "000-0000-0000",
      is_active: true
    }
  ]
})

corporate_user = CorporateUser.create!({
  tel: "100-0000-0000",
  name: "corporate_user",
  payments_attributes: [
    {
      kind: "credit",
      number: "100-0000-0000",
      is_active: true
    }
  ]
})

personal_user_1 = PersonalUser.create!({
  tel: "000-0000-0001",
  name: "personal_user_1",
  payments_attributes: [
    {
      kind: "credit",
      number: "200-0000-0001",
      is_active: true
    },
    {
      kind: "bank",
      number: "200-0000-0002",
      is_active: true
    }
  ]
})

personal_user_2 = PersonalUser.create!({
  tel: "200-0000-0002",
  name: "personal_user_2",
  payments_attributes: [
    {
      kind: "credit",
      number: "300-0000-0001",
      is_active: true
    }
  ]
})

Trade.create!({
  active_payment: admin_user.payments.first,
  passive_payment: personal_user_1.payments.first,
  amount: 10000
})

Trade.create!({
  active_payment: admin_user.payments.first,
  passive_payment: personal_user_2.payments.first,
  amount: 10000
})

Trade.create!({
  active_payment: personal_user_1.payments.second,
  passive_payment: personal_user_1.payments.first,
  amount: 3000
})

Trade.create!({
  active_payment: personal_user_1.payments.first,
  passive_payment: personal_user_2.payments.first,
  amount: 3000
})

Trade.create!({
  active_payment: personal_user_1.payments.first,
  passive_payment: corporate_user.payments.first,
  amount: 3000
})
