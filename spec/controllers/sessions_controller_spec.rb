require "rails_helper"

RSpec.describe SessionsController, type: :controller do
  describe "#new" do
    before { get :new }

    it :aggregate_failures do
      expect(response).to have_http_status :ok
      expect(response).to render_template :new
    end
  end

  describe "#create" do
    let!(:user) { create(:personal_user, email: email, password: password) }
    let(:email) { "test_user@test.com" }
    let(:password) { "password" }

    context "when sign in success" do
      before do
        user.account_activation.update_attribute(:activated, true)
        post :create, params: { session: { email: email, password: password } }
      end

      it :aggregate_failures do
        expect(session[:user_id]).to eq user.id
        expect(response).to have_http_status :redirect
        expect(flash[:success]).not_to be_empty
      end
    end

    context "when user isn't activated" do
      before { post :create, params: { session: { email: email, password: password } } }
      
      it :aggregate_failures do
        expect(session[:user_id]).to be_nil
        expect(response).to render_template :new
        expect(flash[:danger]).not_to be_empty
      end
    end

    context "when user not found" do
      before { post :create, params: { session: { email: "invalid@example.com", password: password } } }

      it :aggregate_failures do
        expect(session[:user_id]).to be_nil
        expect(response).to render_template :new
        expect(flash[:danger]).not_to be_empty
      end
    end

    context "when user can't authenticate" do
      before { post :create, params: { session: { email: email, password: "invalid_password" } } }

      it :aggregate_failures do
        expect(session[:user_id]).to be_nil
        expect(response).to render_template :new
        expect(flash[:danger]).not_to be_empty
      end
    end
  end
end
