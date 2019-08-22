require "rails_helper"

RSpec.describe UsersController, type: :controller do
  describe "#index" do
    context "when visit index" do
      before { get :index }

      it :aggregate_failures do
        expect(response).to have_http_status :ok
        expect(response).to render_template :index
      end
    end
  end

  describe "#destroy" do
    let!(:user) { create(:personal_user) }

    it :aggregate_failures do
      expect {
        delete :destroy, params: { id: user.id }
      }.to change { User.count }.by(-1)
      expect(response).to have_http_status :redirect
      expect(flash[:success]).not_to be_empty
    end
  end
end
