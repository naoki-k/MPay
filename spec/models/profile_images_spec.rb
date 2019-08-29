require "rails_helper"

RSpec.describe ProfileImage, type: :model do
  describe "valid?" do
    context "when correct params" do
      let(:profile_image) { build(:profile_image) }

      it { expect(profile_image).to be_valid }
    end

    context "when no relation for user" do
      let(:profile_image) { build(:profile_image, user: nil) }

      it { expect(profile_image).not_to be_valid }
    end

    context "when image is empty" do
      let(:profile_image) { build(:profile_image, image: "") }

      it { expect(profile_image).not_to be_valid }
    end

    context "when image validation" do
      let(:profile_image) { build(:profile_image) }

      it :aggregate_failures do
        expect { profile_image.valid? }.to change { profile_image.image }
      end
    end
  end
end
