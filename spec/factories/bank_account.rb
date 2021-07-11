FactoryBot.define do
  factory :bank_account do
    name { Faker::Name.name }
    account_number { Faker::Bank.account_number }
    amount { rand(1..9999) }
    user
  end
end
