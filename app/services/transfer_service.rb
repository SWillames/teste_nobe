  class TransferService
    def initialize(operations_params)
      @account = Account.find(operations_params[:account_id])
      @kind = operations_params[:kind]
      @recipient = operations_params[:recipient]
      @amount = operations_params[:amount].try(:to_f)
      @recipient_account = Account.where(account_number: @recipient).first
    end
    
    def execute!
     @operation = create_operation!(@account, @kind, @recipient_account, @amount)
    end

    private

    def create_operation!(account, kind, recipient, amount)
      op = Operation.new(account: account, 
                          kind: kind,
                          recipient: recipient,
                          amount: amount
      )
      if op.save!
        account.update(balance: account.balance - amount) 
        recipient.update(balance: recipient.balance + amount) 
        op
      else
        raise ActiveRecord::Rollback unless account.present?
      end
    end 
  end
