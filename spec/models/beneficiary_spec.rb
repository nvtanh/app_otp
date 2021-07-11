require 'rails_helper'

RSpec.describe Beneficiary, type: :model do
  describe 'Associations' do
    it { should belong_to(:bank_account) }
    it { should belong_to(:user) }
    it { should have_many(:transactions).dependent(:destroy) }
  end
end
