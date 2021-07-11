require 'rails_helper'

RSpec.describe Dashboard::BeneficiariesController, type: :controller do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }

  describe "GET /dashboard/beneficiaries" do
    let!(:beneficiary_1) { create(:beneficiary, user: user) }
    let!(:beneficiary_2) { create(:beneficiary, user: user) }
    let!(:beneficiary_3) { create(:beneficiary, user: user) }
    let!(:other_beneficiary) { create(:beneficiary, user: other_user) }

    context 'unauthorized access' do
      before { get :index }
      it { expect(response).to redirect_to(login_path) }
    end

    context 'When log in as User' do
      before do
        login_as(user)
        get :index
      end

      it { expect(response).to have_http_status(:success) }
      it { expect(assigns(:beneficiaries).size).to eq 3 }
    end
  end

  describe "POST /dashboard/beneficiaries" do
    let!(:bank_account) { create(:bank_account) }

    context 'unauthorized access' do
      before { get :index }
      it { expect(response).to redirect_to(login_path) }
    end

    context 'When log in as User' do
      subject { post :create, params: params }

      before { login_as(user) }

      context 'when valid params' do
        let(:params) do
          {
            beneficiary: {
              bank_account_id: bank_account.id,
              nick_name: Faker::Name.name
            }
          }
        end

        it { expect { subject }.to change(Beneficiary, :count).by(1) }
      end

      context 'when valid params' do
        let(:params) do
          {
            beneficiary: {
              bank_account_id: bank_account.id,
              nick_name: ""
            }
          }
        end

        it { expect { subject }.to change(Beneficiary, :count).by(0) }

        it 'render new' do
          subject
          expect(response).to render_template(:new)
        end
      end
    end
  end
end
