require 'rails_helper'

RSpec.feature "RegisterUsers", type: :feature do
  it "can create a user and store their information in the database" do
    visit '/registration/register'

    fill_reg_page
    expect(page).to have_text("Shane")
    expect(page).to have_text("McCorkle")
    expect(page).to have_text("user1")
    expect(page).to have_text("pass1")
    expect(page).to have_text("123-456-7890")
    expect(page).to have_text("No Phone")

  end

  def fill_reg_page
    page.fill_in 'First Name', with: 'Shane'
    page.fill_in 'Last Name', with: 'McCorkle'
    page.fill_in 'Street Address', with: '123 Fake St.'
    page.fill_in 'City', with: 'San Diego'
    page.fill_in 'State', with: 'CA'
    page.fill_in 'Zip Code', with: '92130'
    page.fill_in 'Country', with: 'US'
    page.fill_in 'User Name', with: 'user1'
    page.fill_in 'Password', with: 'pass1'
    page.fill_in 'Phone Number 1', with: '123-456-7890'
    click_button 'Register'
  end
end
