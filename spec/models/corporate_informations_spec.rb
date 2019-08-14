require "rails_helper"

RSpec.describe CorporateInformation, type: :model do
  describe "#valid?" do
    context "when validation with correct params" do
      let(:corporate_information) { build(:corporate_information) }

      it { expect(corporate_information).to be_valid }
    end

    context "when adress is blank" do
      let(:corporate_information) { build(:corporate_information, address: "") }

      it { expect(corporate_information).not_to be_valid }
    end

    context "when no relation for corporate_user" do
      let(:corporate_information) { build(:corporate_information, corporate_user: nil) }

      it { expect(corporate_information).not_to be_valid }
    end

    context "when parameters length are wrong" do
      let(:corporate_information) { build(:corporate_information, detail: "a" * 65536) }

      it { expect(corporate_information).not_to be_valid }
    end
  end
end
