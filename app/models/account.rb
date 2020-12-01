class Account < ApplicationRecord
  belongs_to :customer
  

  before_save :load_standart

  def load_standart
    if self.new_record?
      self.account_number = (SecureRandom.random_number * (10**5)).round
      self.balance = 0.0
    end
  end
  
end
