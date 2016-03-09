require 'rails_helper'

RSpec.feature "RegisterUsers", type: :feature do
  it "can create a user and store their information in the database" do
    visit '/'
    fill_reg_page
    expect(page).to have_text("Shane")
    expect(page).to have_text("McCorkle")
    expect(page).to have_text("User111")
    expect(page).to have_text("123-456-7890")
    expect(page).to have_text("No Phone")
  end

  it "can verify that a username is already in use and not create another user with same username" do
    visit '/'
    page.fill_in 'User Name', with: 'User111'
    page.fill_in 'Password', with: 'pass1!!!'
    click_on 'Register'
    click_on 'Log Out'
    # save_and_open_page
    click_on 'Register'
    fill_reg_page
    expect(page).to have_text("User ID taken, try another.")
  end

  it "validate password" do
    visit '/'
    page.fill_in 'User Name', with: 'User111'
    page.fill_in 'Password', with: 'pass1'
    click_on 'Register'
    expect(page).to have_text("Password must have more than 6 characters")
  end

  it "can log in" do
    visit '/'
    fill_reg_page
    click_on 'Login'
    page.fill_in 'User Name', with: 'User111'
    page.fill_in 'Password', with: 'pass1!!!'
    click_on 'Login'
    expect(page).to have_text("Shane")
    expect(page).to have_text("McCorkle")
    expect(page).to have_text("User111")
    expect(page).to have_text("123-456-7890")
    expect(page).to have_text("No Phone")
  end

  it "can log out" do
    visit '/'
    fill_reg_page
    click_on 'Login'
    page.fill_in 'User Name', with: 'User111'
    page.fill_in 'Password', with: 'pass1!!!'
    click_on 'Login'
    click_on 'Log Out'
    expect(page).to have_text("You are now logged out")
  end

  def fill_reg_page
    page.fill_in 'First Name', with: 'Shane'
    page.fill_in 'Last Name', with: 'McCorkle'
    page.fill_in 'Street Address', with: '123 Fake St.'
    page.fill_in 'City', with: 'San Diego'
    page.fill_in 'State', with: 'CA'
    page.fill_in 'Zip Code', with: '92130'
    page.fill_in 'Country', with: 'US'
    page.fill_in 'User Name', with: 'User111'
    page.fill_in 'Password', with: 'pass1!!!'
    page.fill_in 'Phone Number 1', with: '123-456-7890'
    click_button 'Register'
  end

end
