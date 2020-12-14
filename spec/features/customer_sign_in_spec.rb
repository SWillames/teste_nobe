require 'rails_helper'

feature 'Customer sign in' do
  let(:customer) { create(:customer) } 
  scenario 'from home page' do
    visit root_path
    
    expect(page).to have_link('Sign_in')
  end

  scenario 'successfully' do

    visit root_path
    click_on 'Sign_in'
    fill_in "Email",	with: customer.email
    fill_in "Password",	with: customer.password
    click_on "Log in"
    
    expect(page).to have_content customer.first_name
    expect(page).to have_content 'Signed in successfully.'
    expect(page).to have_link 'Profile'
    expect(page).to have_link 'My Account'
    expect(page).to have_link 'Logout'
    expect(page).not_to have_link 'Sign_in'
  end

  scenario 'and sign out' do
    login_as(customer)

    visit root_path
    click_on "Logout"

    expect(page).to have_content 'Welcome Visitor'
    expect(page).to have_content 'Signed out successfully.'
    expect(page).to have_link 'Sign_in'
    expect(page).to have_link 'Sign_up'
    expect(page).not_to have_link 'Profile'
    expect(page).not_to have_link 'My Account'
    expect(page).not_to have_link 'Logout'
  end
end
