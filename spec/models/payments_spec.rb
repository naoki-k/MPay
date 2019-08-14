require "rails_helper"

RSpec.describe Payment, type: :model do
  describe "#valid?" do
    context "when parent instance" do
      let(:payment) { build(:payment) }

      it { expect(payment).not_to be_valid }
    end

    context "when any of child instance" do  
      it :aggregate_failures do
        expect(build(:bank_payment)).to be_valid
        # credit_paymentをsaveする前に書き換えたとき
        expect(build(:credit_payment)).to be_valid
      end
    end

    context "when number is blank" do
      it { expect(build(:bank_payment, number: "")).not_to be_valid }
    end

    context "when no relation for user" do
      it { expect(build(:bank_payment, user: nil)).not_to be_valid }
    end

    context "when credit is already exist" do
      let(:user) { build(:personal_user) }
      let(:credit_payment_attributes) { attributes_for(:credit_payment) }
      before do
        user.build_credit_payment(credit_payment_attributes)
        user.save
      end

      it { expect(build(:credit_payment, user: user)).not_to be_valid }
    end

    context "when invalid type" do
      it { expect { build(:bank_payment, type: "Invalid Type") }.to raise_error(ArgumentError) }
    end

    context "when parameters length are wrong" do
      it { expect(build(:bank_payment, number: "1" * 256)).not_to be_valid }
    end
  end

  describe "#save" do
    context "when save" do
      let(:user) { create(:personal_user) }
      let(:number) { "ABC123" }
      let(:new_bank_payment) { create(:bank_payment, number: number, user: user) }
      it { expect(new_bank_payment.reload.number).not_to eq number }
    end
  end

  describe "#decrypted_number" do
    let(:user) { create(:personal_user) }
    let(:number) { "ABC123" }
    let(:new_bank_payment) { create(:bank_payment, number: number, user: user) }

    it :aggregate_failures do
      expect(new_bank_payment.reload.number).not_to eq number
      expect(new_bank_payment.reload.decrypted_number).to eq number
    end
  end
end
