class User < ApplicationRecord
  EMAIL_REGEX = /\A[^@\s]+@[^@\s]+\z/

  has_many :one_time_passwords, dependent: :destroy
  has_many :bank_accounts, dependent: :destroy
  has_many :beneficiaries, dependent: :destroy

  validates :email, presence: true,
    format: { with: EMAIL_REGEX, message: "is invalid" }
end
