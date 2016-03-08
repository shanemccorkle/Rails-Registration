require 'rails_helper'

RSpec.feature "RegisterUsers", type: :feature do
  it "can create a user and store their information in the database" do
    visit '/registration/register'

    page.fill_in 'First Name', with: 'Shane'
    page.fill_in 'Last Name', with: 'McCorkle'
    page.fill_in 'User Name', with: 'user1'
    page.fill_in 'Password', with: 'pass1'
    click_button 'Register'
    expect(page).to have_text("Shane")
    expect(page).to have_text("McCorkle")
    expect(page).to have_text("user1")
    expect(page).to have_text("pass1")
  end
end
