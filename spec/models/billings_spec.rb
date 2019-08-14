require "rails_helper"

RSpec.describe Billing, type: :model do
  describe "#valid?" do
    context "when validation with correct params" do
      let(:billing) { build(:billing) }

      it { expect(billing).to be_valid }
    end

    context "when amount is blank" do
      let(:billing) { build(:billing, amount: "") }

      it { expect(billing).not_to be_valid }
    end

    context "when no relation for user" do
      it :aggregate_failures do
        expect(build(:billing, sender: nil)).not_to be_valid
        expect(build(:billing, receiver: nil)).not_to be_valid
      end
    end

    context "when parameters length are wrong" do
      it do
        expect(build(:billing, content: "a" * 65536)).not_to be_valid
      end
    end
  end
end
