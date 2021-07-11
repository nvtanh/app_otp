FactoryBot.define do
  factory :transaction do
    beneficiary
    sender_account_id { 1 }
    amount { rand(1..100) }
  end
end
