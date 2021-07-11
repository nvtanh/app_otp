require 'rails_helper'

RSpec.describe BankAccount, type: :model do
  describe 'Associations' do
    it { should belong_to(:user) }
  end

  describe 'validation' do
    it { should validate_presence_of(:amount) }
    it { should validate_numericality_of(:amount).is_greater_than(0) }
  end

  describe '#deposit' do
    let!(:bank_account) { create(:bank_account, amount: 100) }

    context 'when deposit amount is valid' do
      subject { bank_account.deposit!(10) }

      it { expect { subject }.to change(bank_account, :amount).by(10) }
    end

    context 'when deposit amount is invalid' do
      it { expect { bank_account.deposit!(-10) }.to raise_error(OtpError) }
    end
  end

  describe '#withdrawal!' do
    let!(:bank_account) { create(:bank_account, amount: 100) }

    context 'when withdrawal amount is valid' do
      context 'when available amount is enough' do
        subject { bank_account.withdrawal!(10) }

        it { expect { subject }.to change(bank_account, :amount).by(-10) }
      end

      context 'when available amount is NOT enough' do
        subject { bank_account.withdrawal!(110) }

        it { expect { subject }.to raise_error }
      end
    end

    context 'when withdrawal amount is invalid' do
      it { expect { bank_account.withdrawal!(-10) }.to raise_error(OtpError) }
    end
  end
end
