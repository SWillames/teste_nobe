class OperationsController < ApplicationController
  before_action :authenticate_customer!
  layout 'search', only: [:index] 
  def index
    account = current_customer.account
    @operations = Operation.where(account_id: account.id)
  end
  
 
  def show
    @operation = Operation.find(params[:id])
  end
  
  def new_deposit
   @operation = Operation.new
   @account = current_customer.account
   @kind = "deposit"
   @interest_rate = 0
  end

  def create_deposit
    @errors = ValidationOperationService.new(operations_params).execute!
    if @errors.empty?
      @operation = OperationService.new(operations_params).execute!
      redirect_to @operation
    else
      redirect_to :new_deposit
    end
  end

  def new_withdraw
    @operation = Operation.new
    @account = current_customer.account
    @kind = "withdraw"
    @interest_rate = 0
  end

  def create_withdraw
    @errors = ValidationOperationService.new(operations_params).execute!
    if @errors.empty?
      @operation = OperationService.new(operations_params).execute!
      redirect_to @operation
    else
      redirect_to "new_withdraw"
    end
  end

  def new_transfer
    @operation = Operation.new
    @account = current_customer.account
    @kind = "transfer"
  end

  def create_transfer
    @errors = ValidationOperationService.new(operations_params).execute!
    if @errors.empty?
      @operation = OperationService.new(operations_params).execute!
      redirect_to @operation
    else
      redirect_to "new_transfer"#json: {errors: @errors}, status: 402 if @errors.size > 0 
    end
  end

  private
  def operations_params
    params.require(:operation).permit(:account_id, :kind, :recipient, :amount, :interest_rate)
  end
end