require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'Associations' do
    it { should belong_to(:beneficiary) }
    it { should belong_to(:sender_account) }
  end

  describe 'validation' do
    it { should validate_presence_of(:amount) }
    it { should validate_numericality_of(:amount).is_greater_than(0) }
  end

  describe 'Scope' do
    describe '.newest' do
      let!(:transaction_1) { create(:transaction, created_at: "2021-07-11 10:00") }
      let!(:transaction_2) { create(:transaction, created_at: "2021-07-11 11:00") }
      let!(:transaction_3) { create(:transaction, created_at: "2021-07-11 12:00") }

      it "return list transactions newest" do
        expect(Transaction.newest).to eq [transaction_3, transaction_2, transaction_1]
      end
    end
  end
end
