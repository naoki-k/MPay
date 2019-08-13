require "rails_helper"

RSpec.describe User, type: :model do
  describe "#valid?" do
    context "when parent class" do
      let(:user) { build(:user) }
      it { expect(user).not_to be_valid }
    end
  end

  describe "tradable?" do

  end

  describe "trades" do
    
  end
end
