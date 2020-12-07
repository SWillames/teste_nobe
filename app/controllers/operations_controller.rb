class OperationsController < ApplicationController
  before_action :authenticate_customer!
  def index
    @operations = Operation.where(account_id: current_customer)
  end
  
 
  def show
    @operation = Operation.find(params[:id])
  end
  
  def new_deposit
   @operation = Operation.new
   @account = current_customer.account
  end

  def create_deposit
    @account = current_customer.account
    @operation = Operation.new(kind: "deposit", amount: params[:operation][:amount], 
                               account_id: @account.id, 
                               recipient: @account.account_number)
    if @operation.save
      @account.update(balance: @account.balance += @operation.amount)
      redirect_to @operation
    else
      render :new_deposit
    end
  end

  def new_withdraw
    @operation = Operation.new
    @account = current_customer.account
  end

  def create_withdraw
    @account = current_customer.account
    @operation = Operation.new(kind: "whithdraw", amount: params[:operation][:amount], 
                               account_id: @account.id, 
                               recipient: @account.account_number)
    if (@operation.amount > @account.balance)
      flash[:notice] = "Your balance is not enough"
      render 'new_withdraw'
    else
      if @operation.save
        redirect_to @operation, notice: 'Operation was successfully!'
        @account.update(balance: @account.balance -= @operation.amount)
      else
        render "new_withdraw"
      end
    end
  end

  def new_transfer
    @operation = Operation.new
    @account = current_customer.account
  end

  def create_transfer
    @errors = ValidationTransferService.new(operations_params).execute!
    if @errors.empty?
      @operation = TransferService.new(operations_params).execute!
    else
      render json: {errors: @errors}, status: 402 if @errors.size > 0 
    end
  end

  private
  def operations_params
    params.require(:operation).permit(:account_id, :kind, :recipient, :amount)
  end
end