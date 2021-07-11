class Beneficiary < ApplicationRecord
  belongs_to :user
  belongs_to :bank_account
  has_many :transactions, dependent: :destroy

  delegate :name, :account_number, to: :bank_account, prefix: :bank

  validates :nick_name, presence: true
end
