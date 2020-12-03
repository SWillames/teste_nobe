class AccountsController < ApplicationController
  def show
    @operation = Operation.find(params[:id])
  end
  
end
