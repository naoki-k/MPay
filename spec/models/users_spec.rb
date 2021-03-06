require "rails_helper"

RSpec.describe User, type: :model do
  describe "#valid?" do
    context "when parent instance" do
      let(:user) { build(:user) }
      it { expect(user).not_to be_valid }
    end

    context "when any of child instance" do
      it :aggregate_failures do
        expect(build(:admin_user)).to be_valid
        expect(build(:corporate_user)).to be_valid
        expect(build(:personal_user)).to be_valid
      end

      context "when tel is blank" do
        let(:user) { build(:personal_user, tel: "") }

        it { expect(user).not_to be_valid }
      end

      context "when name is blank" do
        let(:user) { build(:personal_user, name: "") }

        it { expect(user).not_to be_valid }
      end

      context "when password is blank" do
        let(:user) { build(:user, password: "") }

        it { expect(user).not_to be_valid }
      end

      context "when email is blank" do
        let(:user) { build(:user, email: "") }

        it { expect(user).not_to be_valid }
      end

      context "when email already used" do
        let(:email) { "sample@example.com" }
        let(:user) { build(:user, email: email) }
        before { create(:personal_user, email: email) }

        it { expect(user).not_to be_valid }
      end

      context "when password is not confirmed" do
        let(:user) { build(:user, :with_confirmation, password_confirmation: "invalid") }

        it { expect(user).not_to be_valid }
      end

      context "when credit payment is nothing" do
        let(:user) { build(:personal_user) }
        before do
          User.skip_callback(:validation, :before, :create_mpay_credit)
        end
        
        after do
          User.set_callback(:validation, :before, :create_mpay_credit)
        end

        it { expect(user).not_to be_valid }
      end

      context "when parameters length are wrong" do
        it :aggregate_failures do
          expect(build(:personal_user, tel: "0" * 26)).not_to be_valid
          expect(build(:personal_user, name: "a" * 26)).not_to be_valid
          expect(build(:personal_user, email: "a" * 256 + "@example.com")).not_to be_valid
          expect(build(:personal_user, password: "a" * 5)).not_to be_valid
          expect(build(:personal_user, password: "a" * 31)).not_to be_valid
        end
      end

      context "when invalid type" do
        it { expect { build(:user, type: "InvalidType") }.to raise_error(ArgumentError) }
      end
    end
  end

  describe "tradable?" do
    let(:user) { create(:personal_user) }
    context "when credit payment is active" do
      before { user.credit_payment.update_attribute(:is_active, true) }
      it { expect(user).to be_tradable }
    end

    context "when bank payment is active" do
      before do
         user.credit_payment.is_active = false
         create(:bank_payment, user: user)
      end
      
      it { expect(user).to be_tradable }
    end

    context "when any paymen is active" do
      before { user.credit_payment.is_active = false }

      it { expect(user).not_to be_tradable }
    end
  end

  describe "trades" do
    let(:user) { create(:personal_user) }
    let(:other_user) { create(:personal_user) }
    let(:user_bank_payment) { create(:bank_payment, user: user) }

    before {
      user.credit_payment.update_attribute(:is_active, true)
      other_user.credit_payment.update_attribute(:is_active, true)
    }

    let!(:charge_trade) { create(:trade, active_payment: user_bank_payment,
                                         passive_payment: user.credit_payment) }
    let!(:trade_with_other_user) { create(:trade, active_payment: user.credit_payment,
                                                  passive_payment: other_user.credit_payment)}

    it { expect(user.trades).to eq [charge_trade, trade_with_other_user] }
  end

  describe "create" do
    let(:params) { attributes_for(:personal_user) }
    
    it do
      expect(params.include?(:code)).to be_falsey
      user = User.create(params)
      expect(user.code).not_to be_empty
    end
  end
end
