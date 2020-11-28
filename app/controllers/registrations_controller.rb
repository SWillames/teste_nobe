class RegistrationsController < Devise::RegistrationsController

  def create
    super
    if @customer.save
      customer = Customer.last
      Account.create!(customer: customer)  
    end
  end
  

  private

  def sign_up_params
    params.require(:customer).permit(:first_name, :last_name, :email, :rg, :cpf, :address, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:customer).permit(:first_name, :last_name, :email, :rg, :cpf, :address, :password, :password_confirmation)
  end
end