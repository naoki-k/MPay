require "rails_helper"

RSpec.describe MyPagesController, type: :controller do
  describe "#show" do
    context "when any user is sign in" do
      before { get :show }

      it { expect(response).to redirect_to sign_in_url }
    end

    context "when current user is admin" do
      let(:admin) { create(:admin_user) }
      before { get :show, session: { user_id: admin.id } }

      it :aggregate_failures do
        expect(response).to have_http_status :ok
        expect(response).to render_template "my_pages/admin_user/show"
      end
    end

    context "when current user is corporate" do
      let(:corporate) { create(:corporate_user) }
      before { get :show, session: { user_id: corporate.id} }

      it :aggregate_failures do
        expect(response).to have_http_status :ok
        expect(response).to render_template "my_pages/corporate_user/show"
      end
    end

    context "when current user is personal" do
      let(:personal) { create(:personal_user) }
      before { get :show, session: { user_id: personal.id } }

      it :aggregate_failures do
        expect(response).to have_http_status :ok
        expect(response).to render_template "my_pages/personal_user/show"
      end
    end
  end
end
