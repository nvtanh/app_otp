class ExecuteTransactionService
  def initialize beneficiary, transaction
    @beneficiary = beneficiary
    @transaction = transaction
  end

  def call
    is_success, errors = true, ""
    ActiveRecord::Base.transaction do
      @transaction.save!
      @transaction.sender_account.withdrawal!(@transaction.amount)
      @beneficiary.bank_account.deposit!(@transaction.amount)
    end
    [is_success, errors]
  rescue StandardError => e
    is_success = false
    errors = e.message
    [is_success, errors]
  end
end
