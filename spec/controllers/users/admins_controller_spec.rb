require "rails_helper"

RSpec.describe Users::AdminsController, type: :controller do
  describe "#new" do
    before { get :new }

    it :aggregate_failures do
      expect(response).to have_http_status :ok
      expect(response).to render_template :new
    end
  end

  describe "#create" do
    context "when register success" do
      let(:params) { attributes_for(:admin_user, :with_confirmation) }

      it :aggregate_failures do
        expect {
          post :create, params: { admin_user: params }
        }.to change { User.count }.by(1)
        expect(response).to have_http_status :redirect
        expect(flash[:success]).not_to be_empty
      end
    end

    context "when register failed" do
      let(:params) { attributes_for(:admin_user, :with_confirmation, email: nil) }

      it :aggregate_failures do
        expect {
          post :create, params: { admin_user: params }
        }.not_to change { User.count }
        expect(response).to render_template :new
        expect(flash[:danger]).not_to be_empty
      end
    end
  end
end
