require "rails_helper"

RSpec.describe BankPayment, type: :model do
  describe "#valid?" do
    context "when validation with correct params" do
      let(:bank_payment) { build(:bank_payment) }

      it { expect(bank_payment).to be_valid }
    end

    context "when no relation for bank" do
      let(:bank_payment) { build(:bank_payment, bank: nil) }

      it { expect(bank_payment).not_to be_valid }
    end
  end
end
