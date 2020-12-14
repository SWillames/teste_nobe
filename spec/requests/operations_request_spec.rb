require 'rails_helper'

RSpec.describe "Operations", type: :request do

  describe "GET /operations/:id" do
    context "when exist" do
      let(:customer) { create(:customer) } 
      let(:account) { create(:account, customer_id: customer.id) } 
      let(:operations_number) { Random.rand(9) }
      

      before do
        login_as(customer)
         (operations_number+5).times { create(:operation, kind: "deposit", 
                                   amount: 1000, account_id: account.id) }
      end 

      it "return list operations" do
        get "/operations?page=1"
        expect(response).to have_http_status(:success)
      end
    end
  end
  
end
