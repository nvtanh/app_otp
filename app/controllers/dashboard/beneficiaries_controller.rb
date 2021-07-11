class Dashboard::BeneficiariesController < Dashboard::BaseController
  def index
    @beneficiaries = current_user.beneficiaries.includes(:bank_account)
  end

  def new
    @beneficiary = current_user.beneficiaries.build
    @bank_accounts = BankAccount.all
  end

  def create
    @beneficiary = current_user.beneficiaries.new(beneficiary_params)
    if @beneficiary.save
      redirect_to dashboard_beneficiaries_path
    else
      render :new
    end
  end

  def show
    @beneficiary = current_user.beneficiaries.find(params[:id])
    @transactions = @beneficiary.transactions.newest.includes(:sender_account)
  end

  private

  def beneficiary_params
    params.require(:beneficiary)
      .permit(:nick_name, :bank_account_id)
  end
end
