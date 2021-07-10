require 'rails_helper'

RSpec.describe OneTimePassword, type: :model do
  subject { build(:one_time_password) }

  describe 'Associations' do
    it { should belong_to(:user) }
  end

end
