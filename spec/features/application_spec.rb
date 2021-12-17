require 'rails_helper'

RSpec.describe 'welcome page' do
  it "displays a link to the homepage" do
    visit '/'

    expect(page).to have_link('Home')
    expect(page).to have_button('Create a New User')
    expect(page).to have_button('I already have an account')
    expect(page).to have_content('Viewing Party')
  end

  it "can create a user" do
    visit '/'

    click_on('Create a New User', match: :first)

    expect(current_path).to eq('/register')
  end

  it "lists existing users email addresses and links to their dashboard" do
    user = User.create!(name: "Stephanie", email: "steph123@hotmail.com", password: '789', password_confirmation: '789')
    user2 = User.create!(name: "Ted", email: "tstaros23@hotmail.com", password: 'ted', password_confirmation: 'ted')

    visit '/login'
    fill_in :email, with: "tstaros23@hotmail.com"
    fill_in :password, with: 'ted'
    click_button 'Log In'

    visit '/dashboard'
    click_link 'Home'

    expect(page).to have_content(user.name)
    expect(page).to have_content(user2.name)
  end

  it 'shows a logged in user a logout button' do
    user = User.create!(name: "Stephanie", email: "steph123@hotmail.com", password: '123', password_confirmation: '123')

    visit '/login'
    fill_in :email, with: "steph123@hotmail.com"
    fill_in :password, with: '123'
    click_button 'Log In'

    visit '/'
    expect(page).to have_button('Log Out')

    click_button 'Log Out'

    expect(current_path).to eq('/')
    expect(page).to have_button("I already have an account")
    expect(page).to have_button('Create a New User')
  end

  it 'does not show a visitor the existing users' do
    visit '/'

    expect(page).to_not have_content('Existing Users')
  end

  it 'does show a registered user existing users email addresses' do
    user1 = User.create!(name: "Stephanie", email: "steph123@hotmail.com", password: '123', password_confirmation: '123')
    user2 = User.create!(name: "Meg", email: "meg@turing.com", password: 'test', password_confirmation: 'test')

    visit '/login'
    fill_in :email, with: "steph123@hotmail.com"
    fill_in :password, with: '123'
    click_button 'Log In'

    visit '/'

    expect(page).to have_content('Existing Users')
    expect(page).to have_content(user2.name)
  end
end
