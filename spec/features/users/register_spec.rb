require 'rails_helper'

RSpec.describe 'registration page' do
  it "has a form to create a new user" do
    visit '/register'

    fill_in :name, with: "Stephanie"
    fill_in :email, with: "steph23@hotmail.com"
    fill_in :password, with: '123'
    fill_in :password_confirmation, with: '123'


    click_on('Create New User')

    user = User.last
    expect(user.email).to eq("steph23@hotmail.com")
    expect(user.name).to eq("Stephanie")
    expect(current_path).to eq('/dashboard')
    expect(page).to have_content("Stephanie")
  end

  it 'has a form to create a new user' do

    visit '/register'

    name = 'Meg'
    email = 'meg@test123'

    fill_in :name, with: name
    fill_in :email, with: email
    fill_in :password, with: '123'
    fill_in :password_confirmation, with: '123'

    click_on('Create New User')

    user = User.last
    expect(user.email).to eq(email)
    expect(user.name).to eq(name)
    expect(current_path).to eq('/dashboard')
    expect(page).to have_content("Meg")
  end

  it 'sad path: user not created if passwords dont match' do
    visit '/register'

    name = 'Meg'
    email = 'meg@test123'

    fill_in :name, with: name
    fill_in :email, with: email
    fill_in :password, with: '12345'
    fill_in :password_confirmation, with: '123'

    click_on('Create New User')

    expect(page).to have_content('Password and password confirmation must match.')
  end
end
