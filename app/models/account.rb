class Account < ApplicationRecord
  belongs_to :customer
  
  validates_presence_of :account_number, :balance, :customer_id
  validates :balance, numericality: { greater_than_or_equal_to: 0 }
  validates_format_of :account_number, with: /\A.[0-9]+\z/
  validates_length_of :account_number, in: 4..8 

  before_save :load_standart

  def load_standart
    if self.new_record?
      self.account_number = (SecureRandom.random_number * (10**5)).round
      self.balance = 0.0
    end
  end
  
end
