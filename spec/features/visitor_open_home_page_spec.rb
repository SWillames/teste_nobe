require 'rails_helper'

feature 'Visitor open home page' do
  scenario 'successfully' do
    
    visit root_path


    expect(page).to have_link('Sign_in')
    expect(page).to have_link('Sign_up')
    expect(page).to have_content('Welcome Visitor')
  end
end