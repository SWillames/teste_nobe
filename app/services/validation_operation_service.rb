class ValidationOperationService
  def initialize(operations_params)
    @account = Account.find(operations_params[:account_id])
    @kind = operations_params[:kind]
    @recipient = operations_params[:recipient]
    @amount = operations_params[:amount].try(:to_f)
    @recipient_account = Account.where(account_number: @recipient).first
    @errors = []
  end

  def execute!
    validate_existence_of_account!
    validate_operation! if account_present && transaction_deduction
    @errors
  end

  private

    def validate_operation!
      @errors << "Not enough funds" if @account.balance - @amount < 0.00
    end


    def account_present
      @account.present? && @recipient_account.present?
    end
    def transaction_deduction
      %w(withdraw transfer).include?(@kind)
    end
    
    def validate_existence_of_account!
      @errors << "Account not found" if @account.blank?
      @errors << "Recipient Account not found" if @recipient_account.blank?
    end
end