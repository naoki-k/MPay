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
        }.to change { User.count }.by(1).and change { ActionMailer::Base.deliveries.size }.by(1)
        expect(response).to have_http_status :redirect
        expect(flash[:success]).not_to be_empty
      end
    end

    context "when register failed" do
      let(:params) { attributes_for(:admin_user, :with_confirmation, email: nil) }

      it :aggregate_failures do
        expect {
          post :create, params: { admin_user: params }
        }.to change { User.count }.by(0).and change { ActionMailer::Base.deliveries.size }.by(0)
        expect(response).to render_template :new
        expect(flash[:danger]).not_to be_empty
      end
    end

    context "when register with profile image" do
      context "when valid image" do
        let(:params) { attributes_for(:admin_user, :with_confirmation) }
        let(:image) { fixture_file_upload("spec/factories/images/admin_user.png") }

        it do
          expect {
            post :create, params: { admin_user: params, profile_image: image }
          }.to change { ProfileImage.count }.by(1)
        end
      end

      context "when image is invalid file" do
        let(:params) { attributes_for(:admin_user, :with_confirmation) }
        let(:invalid_file) { fixture_file_upload("spec/factories/images/empty.csv") }

        it :aggregate_failures do
          expect {
            post :create, params: { admin_user: params, profile_image: invalid_file }
          }.to change {User.count}.by(1).and change { ProfileImage.count }.by(0)
          expect(flash[:info]).not_to be_empty
        end
      end
    end
  end
end
