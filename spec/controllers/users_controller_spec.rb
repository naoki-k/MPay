require "rails_helper"

RSpec.describe UsersController, type: :controller do
  describe "#index" do
    context "when user isn't admin" do
      let(:user) { create(:personal_user) }

      it :aggregate_failures do
        expect {
          get :index, session: { user_id: user.id }
        }.not_to change { user.reload.activated? }
        expect(response).to redirect_to sign_in_url
        expect(flash[:danger]).not_to be_empty
      end
    end

    context "when user is admin" do
      let(:admin) { create(:admin_user) }

      context "when visit index" do
        before { get :index, session: { user_id: admin.id } }
  
        it :aggregate_failures do
          expect(response).to have_http_status :ok
          expect(response).to render_template :index
        end
      end
    end
  end

  describe "#destroy" do
    context "when user isn't admin" do
      let(:user) { create(:personal_user) }
      before { session[:user_id] = user.id }

      it :aggregate_failures do
        expect {
          delete :destroy, params: { id: user.id }
        }.not_to change { User.count }
        expect(response).to redirect_to sign_in_url
        expect(flash[:danger]).not_to be_empty
      end
    end

    context "when user is admin" do
      let(:admin) { create(:admin_user) }
      let!(:user) { create(:personal_user) }
      before { session[:user_id] = admin.id }

      it :aggregate_failures do
        expect {
          delete :destroy, params: { id: user.id }
        }.to change { User.count }.by(-1)
        expect(response).to have_http_status :redirect
        expect(flash[:success]).not_to be_empty
      end
    end
  end
end
