class Operation < ApplicationRecord
  belongs_to :account
  KIND = %w[whithdraw deposit transfer]
  belongs_to :account
  validates_presence_of :account, :amount
  validates :kind, presence: true, inclusion: { in: KIND }
  validate :check_withdraw
  validates :amount, numericality: { greater_than: 0 }

  private

  def check_withdraw
    errors.add(:amount, 'Not enough balance in account!') if kind == "withdraw" && amount > account.balance
  end 
end
