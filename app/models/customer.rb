class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :account
  validates_presence_of :email, :first_name, :last_name, :cpf, :address, :rg, :password
  validates_uniqueness_of :email, :cpf
  validates_format_of :email, with: EMAIL_FORMAT
  validates_format_of :cpf, with: /\A.[0-9]+\z/
  validates_length_of :cpf, is: 11


  def full_name
    "#{first_name} #{last_name}" 
  end
  
end
