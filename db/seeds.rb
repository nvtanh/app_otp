### Clear all Data
User.destroy_all
BankAccount.destroy_all
Beneficiary.destroy_all
Transaction.destroy_all

### Create Users
10.times do |i|
  User.create(email: "test_#{i}@example.com")
end

### Create Bank Account
User.all.each do |user|
  user.bank_accounts.create(name: Faker::Name.name,
    account_number: Faker::Bank.account_number, amount: rand(1000))
end
