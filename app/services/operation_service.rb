  class OperationService
    def initialize(operations_params)
      @account = Account.find(operations_params[:account_id])
      @kind = operations_params[:kind]
      @recipient = operations_params[:recipient]
      @amount = operations_params[:amount].try(:to_f)
      @interest_rate = operations_params[:interest_rate]
      @recipient_account = Account.where(account_number: @recipient).first
    end
    
    def execute!
      day = Time.now.wday
      hour = Time.now.hour
      days = [1, 2, 3, 4, 5]
      hours = [9, 10, 11, 12, 13, 14, 15, 16, 17, 18]
     if %w(withdraw deposit).include?(@kind)
      @operation = create_operation!(@account, @kind, @recipient_account, @amount, @interest_rate)
     elsif @kind.eql? "transfer"
      @interest_rate += 10 if @amount > 1000
      if ( days.include?(day) && hours.include?(hour))
        @interest_rate += 5.0
      else
        @interest_rate += 7.0
      end
      @operation = create_transfer_operation!(@account, @kind, @recipient_account, @amount, @interest_rate)
     end
    end

    private

    def create_transfer_operation!(account, kind, recipient, amount, interest_rate)
      op = Operation.new(account: account, 
                          kind: kind,
                          recipient: recipient,
                          amount: amount, 
                          interest_rate: interest_rate
      )
      if op.save!
        account.update(balance: account.balance - amount) 
        recipient.update(balance: recipient.balance + amount) 
        op
      else
        raise ActiveRecord::Rollback unless account.present?
      end
    end
    
    def create_operation!(account, kind, recipient, amount, interest_rate)
      op = Operation.new(account: account, 
                          kind: kind,
                          recipient: recipient,
                          amount: amount, 
                          interest_rate: interest_rate
      )
      if op.save
        account.update(balance: account.balance - amount) if kind == "withdraw" 
        account.update(balance: account.balance + amount) if kind == "deposit"
        op
      else
        raise ActiveRecord::Rollback unless account.present?
      end
    end
  end
