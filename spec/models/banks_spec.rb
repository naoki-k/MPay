require "rails_helper"

RSpec.describe Bank, type: :model do
  describe "#valid?" do
    context "when validation with correct params" do
      let(:bank) { build(:bank) }

      it { expect(bank).to be_valid }
    end

    context "when parameters length are wrong" do
      it :aggregate_failures do
        expect(build(:bank, name: "a" * 26)).not_to be_valid
        expect(build(:bank, code: "a" * 26)).not_to be_valid
      end
    end
  end
end
