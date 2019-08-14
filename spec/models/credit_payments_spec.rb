require "rails_helper"

RSpec.describe CreditPayment, type: :model do
  describe "#balance" do
    let(:user) { create(:personal_user) }
    let(:other_user) { create(:personal_user) }
    let(:my_payment) { user.credit_payment}
    let(:other_payment) { other_user.credit_payment }
    let(:increase_amount) { rand(5000..10000) }
    let(:decrease_amount) { rand(0..5000) }

    before do
      create(:trade, active_payment: other_payment, passive_payment: my_payment, amount: increase_amount)
      create(:trade, active_payment: my_payment, passive_payment: other_payment, amount: decrease_amount)
    end

    it { expect(my_payment.balance).to eq increase_amount - decrease_amount }
  end

  describe "#is_payable?" do
    let(:credit_payment) { build(:credit_payment) }
    before { allow(credit_payment).to receive(:balance).and_return(5000) }

    it :aggregate_failures do
      expect(credit_payment).to be_payable(3000)
      expect(credit_payment).not_to be_payable(10000)
    end
  end
end
