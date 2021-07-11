class Transaction < ApplicationRecord
  belongs_to :beneficiary
  belongs_to :sender_account, foreign_key: :sender_account_id, class_name: BankAccount.name

  delegate :account_number, to: :sender_account, prefix: :sender

  validates :amount, presence: true,
    numericality: { only_float: true, greater_than: 0 }

  scope :newest, -> { order("created_at DESC") }
end
