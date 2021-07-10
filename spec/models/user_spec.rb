require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  describe 'Associations' do
    it { should have_many(:one_time_passwords).dependent(:destroy) }
  end

  describe 'validation' do
    it { should validate_presence_of(:email) }
    it { should allow_value('email@sample.com').for(:email) }
    it { should_not allow_value('email_sample.com').for(:email) }
  end
end
