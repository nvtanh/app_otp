class BankAccount < ApplicationRecord
  belongs_to :user

  validates :amount, presence: true,
    numericality: { only_float: true, greater_than: 0 }

  def deposit!(deposit_amount)
    raise OtpError.new(I18n.t('errors.bank_accounts.deposit_amount_invalid')) unless deposit_amount.positive?

    self.update!(amount: (self.amount + deposit_amount))
  end

  def withdrawal!(withdrawal_amount)
    raise OtpError.new(I18n.t('errors.bank_account.withdrawal_amount_invalid')) unless withdrawal_amount.positive?

    self.update!(amount: (self.amount - withdrawal_amount))
  end
end
