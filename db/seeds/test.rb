admin_user = AdminUser.create!({
  tel: Faker::PhoneNumber.unique.cell_phone,
  name: "admin_user",
  password: "password",
  email: Faker::Internet.unique.email
})
admin_user.credit_payment.update_attribute(:is_active, true)
