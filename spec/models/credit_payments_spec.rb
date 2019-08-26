require "rails_helper"

RSpec.describe CreditPayment, type: :model do
  describe "#balance" do
    let(:user) { create(:personal_user) }
    let(:other_user) { create(:personal_user) }
    let(:admin_user) { create(:admin_user) }
    let(:my_payment) { user.credit_payment }
    let(:other_payment) { other_user.credit_payment }
    let(:admin_payment) { admin_user.credit_payment }
    let(:increase_amount) { rand(5000..10000) }
    let(:decrease_amount) { rand(0..5000) }

    before do
      my_payment.update_attribute(:is_active, true)
      other_payment.update_attribute(:is_active, true)
      admin_payment.update_attribute(:is_active, true)
      create(:trade, active_payment: admin_payment, passive_payment: my_payment, amount: increase_amount)
      create(:trade, active_payment: my_payment, passive_payment: other_payment, amount: decrease_amount)
    end

    it { expect(my_payment.reload.balance).to eq increase_amount - decrease_amount }
  end

  describe "#payable?" do
    context "when it isn't admin" do
      let(:credit_payment) { build(:credit_payment) }
      before { allow(credit_payment).to receive(:balance).and_return(5000) }

      it :aggregate_failures do
        expect(credit_payment).to be_payable(3000)
        expect(credit_payment).not_to be_payable(10000)
      end
    end
    
    context "when it is admin" do
      let(:admin) { build(:admin_user) }
      let(:credit_payment) { build(:credit_payment, user: admin) }

      it { expect(credit_payment).to be_payable(10000) }
    end
  end
end
