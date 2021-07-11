class Dashboard::TransactionsController < ApplicationController
  before_action :load_beneficiary

  def new
    @transaction = @beneficiary.transactions.build
    load_sender_accounts
  end

  def create
    @transaction = @beneficiary.transactions.build(transaction_params)
    is_success, errors = ::ExecuteTransactionService.new(@beneficiary, @transaction).call
    if is_success
      flash[:notice] = "Transaction successfully"
      redirect_to dashboard_beneficiary_path(@beneficiary)
    else
      load_sender_accounts
      flash[:danger] = errors
      render :new
    end
  end

  private

  def load_beneficiary
    @beneficiary ||= current_user.beneficiaries.find(params[:beneficiary_id])
  end

  def transaction_params
    params.require(:transaction)
      .permit(:sender_account_id, :amount)
  end

  def load_sender_accounts
    @sender_accounts ||= current_user.bank_accounts
  end
end
