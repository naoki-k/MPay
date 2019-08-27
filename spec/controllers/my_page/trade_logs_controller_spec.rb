require "rails_helper"

RSpec.describe MyPage::TradeLogsController, type: :controller do
  describe "#show" do
    context "when signed in" do
      let(:user) { create(:personal_user) }
      before { get :show, session: { user_id: user.id } }

      it :aggregate_failures do
        expect(response).to have_http_status :ok
        expect(response).to render_template :show
      end
    end
  end
end
