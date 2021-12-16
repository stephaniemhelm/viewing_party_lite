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
    #click_on('Create a New User')
    expect(current_path).to eq('/register')
  end

  it "lists existing users email addresses and links to their dashboard" do
    user = User.create!(name: "Stephanie", email: "steph123@hotmail.com", password: '789', password_confirmation: '789')
    user2 = User.create!(name: "Ted", email: "tstaros23@hotmail.com", password: 'ted', password_confirmation: 'ted')

    visit '/'

    expect(page).to have_link("tstaros23@hotmail.com")
    expect(page).to have_link("steph123@hotmail.com")

    click_on("tstaros23@hotmail.com", match: :first)

    expect(current_path).to eq("/users/#{user2.id}")
  end
end
