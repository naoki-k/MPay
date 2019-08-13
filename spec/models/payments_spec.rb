require "rails_helper"

RSpec.describe Payment, type: :model do
  describe "#valid?" do
    context "when parent class" do
      let(:user) { build(:personal_user) }
      let(:payment) { build(:payment, user: user) }

      it { expect(payment).not_to be_valid }
    end
  end

  describe "#decrypted_number" do
    
  end
end
