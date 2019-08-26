require "rails_helper"

RSpec.describe TradesController, type: :controller do
  describe "#new" do
    let(:user) { create(:personal_user) }

    context "when sign in" do
      before { get :new, session: { user_id: user.id } }

      it :aggregate_failures do
        expect(response).to have_http_status :ok
        expect(response).to render_template :new
      end
    end
  end

  describe "#confirmation" do
    context "when sign in" do
      let(:user) { create(:personal_user) }
      before { session[:user_id] = user.id }

      context "when correct params" do
        before do
          user.update_attribute(:code, "100")
          post :confirmation, params: { confirmation: { target_user_code: "100", amount: 1000 } }
        end
  
        it { expect(response).to render_template :confirmation }
      end
  
      context "when target user code is blank" do
        before do
          post :confirmation, params: { confirmation: { amount: 1000 } }
        end
  
        it :aggregate_failures do
          expect(response).to render_template :new
          expect(flash[:danger]).not_to be_empty
        end
      end
  
      context "when amount is blank" do
        before do
          user.update_attribute(:code, "100")
          post :confirmation, params: { confirmation: { target_user_code: "100" } }
        end
  
        it :aggregate_failures do
          expect(response).to render_template :new
          expect(flash[:danger]).not_to be_empty
        end
      end
  
      context "when target user code is invalid" do
        before do
          post :confirmation, params: { confirmation: { target_user_code: "200", amount: 1000 } }
        end
  
        it :aggregate_failures do
          expect(response).to render_template :new
          expect(flash[:danger]).not_to be_empty
        end
      end
    end
  end

  describe "#crete" do
    let(:user) { create(:personal_user) }
    let(:target_user) { create(:personal_user) }

    context "when correct params" do
      before do
        user.credit_payment.update_attribute(:is_active, true)
        target_user.credit_payment.update_attribute(:is_active, true)
        Trade.create(passive_payment: user.credit_payment,
                  active_payment: AdminUser.first.credit_payment,
                  amount: 10000)
      end

      it :aggregate_failures do
        expect{
          post :create, params: { trade: { target_user_id: target_user.id, amount: 1000 } }, session: { user_id: user.id }
        }.to change { Trade.count }.by(1)
        expect(response).to have_http_status :redirect
        expect(flash[:success]).not_to be_empty
      end
    end

    context "when trade failed" do
      before do
        user.credit_payment.update_attribute(:is_active, true)
        target_user.credit_payment.update_attribute(:is_active, true)
      end

      it :aggregate_failures do
        expect{
          post :create, params: { trade: { target_user_id: target_user.id, amount: 1000 } }, session: { user_id: user.id }
        }.not_to change { Trade.count }
        expect(response).to render_template :new
        expect(flash[:danger]).not_to be_empty
      end
    end

    context "when target payment not found" do
      before do
        user.credit_payment.update_attribute(:is_active, true)
      end

      it :aggregate_failures do
        expect{
          post :create, params: { trade: { target_user_id: "100", amount: 1000 } }, session: { user_id: user.id }
        }.not_to change { Trade.count }
        expect(response).to render_template :new
      end
    end
  end
end
