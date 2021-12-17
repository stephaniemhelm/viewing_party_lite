require 'rails_helper'

RSpec.describe 'User Log In' do
  it 'user can log in' do
    user = User.create!(name: "Stephanie", email: "steph123@hotmail.com", password: '12345', password_confirmation: '12345')

    visit '/'

    expect(page).to have_button("I already have an account")

    click_on "I already have an account"

    expect(current_path).to eq('/login')

    fill_in :email, with: "steph123@hotmail.com"
    fill_in :password, with: '12345'

    click_button "Log In"
    expect(current_path).to eq('/dashboard')

  end

  it 'sad path: user cant log in with incorrect password' do
    user = User.create!(name: "Stephanie", email: "steph123@hotmail.com", password: '12345', password_confirmation: '12345')

    visit '/'

    expect(page).to have_button("I already have an account")

    click_on "I already have an account"

    expect(current_path).to eq('/login')

    fill_in :email, with: "steph123@hotmail.com"
    fill_in :password, with: '12'

    click_button "Log In"
    expect(current_path).to eq("/login")
    expect(page).to have_content('User email or password not correct.')
  end

  it 'sad path: user cant log in with incorrect email' do
    user = User.create!(name: "Stephanie", email: "steph123@hotmail.com", password: '12345', password_confirmation: '12345')

    visit '/'

    expect(page).to have_button("I already have an account")

    click_on "I already have an account"

    expect(current_path).to eq('/login')

    fill_in :email, with: "steph@yahoo.com"
    fill_in :password, with: '12345'

    click_button "Log In"
    expect(current_path).to eq("/login")
    expect(page).to have_content('User email or password not correct.')
  end
end
