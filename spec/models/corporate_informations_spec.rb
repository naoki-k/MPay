require "rails_helper"

RSpec.describe CorporateInformation, type: :model do
  describe "#valid?" do
    let(:corporate_user) { build(:corporate_user) }
    let(:corporate_information) { build(:corporate_information, corporate_user: corporate_user) }

    it { expect(corporate_information).to be_valid }
  end
end
