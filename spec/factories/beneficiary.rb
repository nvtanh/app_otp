FactoryBot.define do
  factory :beneficiary do
    nick_name { Faker::Name.name }
    bank_account
    user
  end
end
