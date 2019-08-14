require "rails_helper"

RSpec.describe Trade, type: :model do
  describe "#valid?" do
    context "when validation with correct params" do
      let(:trade) { build(:trade) }

      it { expect(trade).to be_valid }
    end

    context "when amount is blank" do
      let(:trade) { build(:trade, amount: "") }

      it { expect(trade).not_to be_valid }
    end

    context "when no relation for payment" do
      it :aggregate_failures do
        expect(build(:trade, active_payment: nil)).not_to be_valid
        expect(build(:trade, passive_payment: nil)).not_to be_valid
      end
    end

    context "when invalid kind" do
      it { expect { build(:trade, kind: "invalid") }.to raise_error(ArgumentError) }
    end
  end

  describe "#type" do
    subject { trade.type }

    let(:trade) { build(:trade, active_payment: active_payment, passive_payment: passive_payment) }

    before do
      allow(trade).to receive(:sender).and_return(active_payment.user)
      allow(trade).to receive(:receiver).and_return(passive_payment.user)
    end

    context "when sender is receiver" do
      let(:user) { build(:user) }
      let(:active_payment) { build(:bank_payment, user: user) }
      let(:passive_payment) { build(:credit_payment, user: user) }

      it { is_expected.to eq charge: "入金" } 
    end

    context "when sender is admin" do
      let(:user) { build(:user) }
      let(:admin_user) { build(:admin_user) }
      let(:active_payment) { build(:payment, user: admin_user) }
      let(:passive_payment) { build(:payment, user: user) }

      it { is_expected.to eq from_mpay: "MPayからの支払い" }
    end

    context "when sender isn't receiver and sender isn't admin" do
      context "when receiver is corporate" do
        let(:user) { build(:user) }
        let(:corporate_user) { build(:corporate_user) }
        let(:active_payment) { build(:payment, user: user) }
        let(:passive_payment) { build(:payment, user: corporate_user) }
  
        it { is_expected.to eq to_corporate: "法人への支払い" }
      end
  
      context "when receiver is personal" do
        let(:user) { build(:user) }
        let(:personal_user) { build(:personal_user) }
        let(:active_payment) { build(:payment, user: user) }
        let(:passive_payment) { build(:payment, user: personal_user) }
  
        it { is_expected.to eq with_personal_user: "ユーザー間取引" }
      end
    end
  end
end

