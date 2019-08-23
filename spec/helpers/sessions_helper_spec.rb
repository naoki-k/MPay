require "rails_helper"

RSpec.describe SessionsHelper, type: :helper do
  describe "#sign_in" do
    let(:user) { create(:personal_user) }
    before { sign_in(user) }

    it { expect(session[:user_id]).to eq user.id }
  end

  describe "#current_user" do
    let(:user) { create(:personal_user) }

    context "when signed in" do
      before { sign_in(user) }

      it { expect(current_user).to eq user }
    end

    context "when no signed user" do
      it { expect(current_user).to be_nil }
    end
  end

  describe "#signed_in?" do
    let(:user) { create(:personal_user) }

    context "when signed in" do
      before { sign_in(user) }

      it { expect(signed_in?).to eq true }
    end
    
    context "when no signed user" do
      it { expect(signed_in?).to eq false }
    end
  end

  describe "current_user?" do
    let(:user) { create(:personal_user) }

    context "when signed in user" do
      before { sign_in(user) }

      it { expect(current_user?(user)).to eq true }
    end

    context "when other user" do
      let(:other_user) { create(:personal_user) }
      before { sign_in(user) }

      it { expect(current_user?(other_user)).to eq false }
    end
  end
end