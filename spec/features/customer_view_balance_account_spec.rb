require 'rails_helper'

feature 'Customer view your account balance' do
  let(:customer) { create(:customer) } 
  let(:account) { build(:account, customer: Customer.last) }

  scenario "Successfully" do
    login_as(customer)
    visit root_path
    
    expect(page).to have_link('Profile') 
    expect(page).to have_link('My Account') 
    expect(page).to have_link('Logout') 

    click_on 'My Account'
    expect(page).to have_content("Your Account")
    expect(page).to have_content("Account Number: ")
    expect(page).to have_content(account.account_number)
    expect(page).to have_content("Balance: ")
    expect(page).to have_content(account.balance)
    expect(page).to have_content("Customer: ")
    expect(page).to have_content(account.customer.full_name)
  end
end