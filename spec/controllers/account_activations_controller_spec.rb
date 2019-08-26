require "rails_helper"

RSpec.describe AccountActivationsController, type: :controller do
  describe "#edit" do
    let!(:user) { create(:personal_user, email: email) }
    let(:email) { "example@test.com" }
    let(:token) { "test_token" }

    context "when correct link" do
      before { user.update_attribute(:activation_digest, BCrypt::Password.create(token)) }

      it :aggregate_failures do
        expect {
          get :edit, params: { id: token, email: email }
        }.to change { user.reload.activated? }.from(false).to(true).and change { user.credit_payment.is_active }.from(false).to(true)
        expect(response).to have_http_status :redirect
        expect(flash[:success]).not_to be_empty
      end
    end

    context "when email is invalid" do
      before { user.update_attribute(:activation_digest, BCrypt::Password.create(token)) }

      it :aggregate_failures do
        expect {
          get :edit, params: { id: token, email: "invalid@test.com" }
        }.not_to change { user.reload.activated? }
        expect(response).to have_http_status :redirect
        expect(flash[:danger]).not_to be_empty
      end
    end

    context "when token is invalid" do
      it :aggregate_failures do
        expect {
          get :edit, params: { id: token, email: email }
        }.not_to change { user.reload.activated? }
        expect(response).to have_http_status :redirect
        expect(flash[:danger]).not_to be_empty
      end
    end
  end

  describe "#authorize" do
    let!(:user) { create(:corporate_user) }

    context "when user isn't admin" do
      it :aggregate_failures do
        expect {
          get :authorize, params: { id: user.id }
        }.not_to change { user.reload.activated? }
        expect(response).to redirect_to sign_in_url
        expect(flash[:danger]).not_to be_empty
      end
    end

    context "when user is admin" do
      let(:admin) { create(:admin_user) }
      before { session[:user_id] = admin.id }

      context "when authorize success" do
        it :aggregate_failures do
          expect {
            get :authorize, params: { id: user.id }
          }.to change { user.reload.activated? }.from(false).to(true).and change { ActionMailer::Base.deliveries.size }.by(1).and change { user.credit_payment.is_active }.from(false).to(true)
          expect(response).to have_http_status :redirect
          expect(flash[:success]).not_to be_empty
        end
      end
  
      context "when user not found" do
        it :aggregate_failures do
          expect {
            get :authorize, params: { id: "invalid" }
          }.not_to change { ActionMailer::Base.deliveries.size }
          expect(response).to render_template "users/index"
          expect(flash[:danger]).not_to be_empty
        end
      end
  
      context "when user already authorized" do
        before { user.update_attribute(:activated, true) }
  
        it :aggregate_failures do
          expect {
            get :authorize, params: { id: user.id }
          }.not_to change { ActionMailer::Base.deliveries.size }
          expect(response).to render_template "users/index"
          expect(flash[:danger]).not_to be_empty
        end
      end
    end
  end
end
