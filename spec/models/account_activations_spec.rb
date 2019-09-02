require "rails_helper"

RSpec.describe AccountActivation, type: :model do
  describe "valid?" do
    context "when correct params" do
      let(:account_activation) { build(:account_activation) }

      it { expect(account_activation).to be_valid }
    end

    context "when no relation for user" do
      let(:account_activation) { build(:account_activation, user: nil) }

      it { expect(account_activation).not_to be_valid }
    end
  end
end
