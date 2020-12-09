class Operation < ApplicationRecord
  belongs_to :account
  KIND = %w[withdraw deposit transfer]
  validates_presence_of :account, :amount, :interest_rate
  validates :kind, presence: true, inclusion: { in: KIND }
  validate :check_withdraw
  validates :amount, numericality: { greater_than: 0 }

  private

  def check_withdraw
    errors.add(:amount, 'Not enough balance in account!') if kind == "withdraw" && amount > account.balance
  end 

  def dateformat
    date = self.created_at
    date.strftime("%dd/%mm/%YYYY")
  end
  
end
