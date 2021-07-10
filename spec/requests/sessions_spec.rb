require 'rails_helper'

RSpec.describe SessionsController, type: :request do
  describe "GET /login" do
    it "returns http success" do
      get "/login"

      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /login" do
    let!(:user) { create(:user) }
    let(:input_otp) { OneTimePassword::DEFAULT_OTP_DEBUG_MODE }
    let!(:otp) { create(:one_time_password, user: user) }
    let(:session_attrs) do
      {
        email: user.email,
        otp: input_otp
      }
    end
    let(:params) { { session: session_attrs } }

    before { post "/login", params: params }

    it "redirect to home dashboard page" do
      expect(response).to redirect_to(dashboard_root_path)
    end

    context "When verify email" do
      context "email is valid" do
        let(:session_attrs) { { email: user.email } }

        it { expect(response).to have_http_status(:success) }
        it { expect(assigns(:user)).to eq(user) }
      end

      context "email is invalid" do
        let(:session_attrs) { {email: "fake_#{user.email}"} }

        it { expect(response).to have_http_status(:success) }
        it { expect(assigns(:user)).to eq(nil) }
        it { expect(flash[:danger]).to match(/User not found*/) }
      end
    end

    context "When otp invalid" do
      let(:session_attrs) do
        {
          email: user.email,
          otp: "otp"
        }
      end

      it { expect(flash[:danger]).to match(/OTP invalid*/) }
    end
  end
end
