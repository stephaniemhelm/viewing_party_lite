require 'rails_helper'

RSpec.describe 'user show page' do
  it 'can show a user attributes' do
    user = User.create!(name: "Stephanie", email: "steph123@hotmail.com", password: '123', password_confirmation: '123')

    visit '/login'
    fill_in :email, with: "steph123@hotmail.com"
    fill_in :password, with: '123'
    click_button 'Log In'

    visit '/dashboard'

    expect(page).to have_content(user.name)
    expect(page).to have_content(user.email)
    expect(page).to have_content("#{user.name}'s Dashboard")
  end

  it 'has a button to Discover Movies' do
    user = User.create!(name: "Stephanie", email: "steph123@hotmail.com", password: '123', password_confirmation: '123')

    visit '/login'
    fill_in :email, with: "steph123@hotmail.com"
    fill_in :password, with: '123'
    click_button 'Log In'

    visit '/dashboard'

    click_on('Discover Movies')
    expect(current_path).to eq('/discover')
  end

  it "has a section that lists viewing parties" do
    party = Party.create!(host_id: 1, movie_id: 3, duration: 24, day: 'Saturday', start_time: "06:10" )
    party2 = Party.create!(host_id: nil, movie_id: 5, duration: 26, day: 'Sunday', start_time: "06:20" )


    user = User.create!(name: "Stephanie", email: "steph123@hotmail.com", password: '123', password_confirmation: '123')

    UserParty.create!(user_id: user.id, party_id: party.id)
    UserParty.create!(user_id: user.id, party_id: party2.id)

    visit '/login'
    fill_in :email, with: "steph123@hotmail.com"
    fill_in :password, with: '123'
    click_button 'Log In'

    visit '/dashboard'


    expect(page).to have_content('Viewing Parties')
    expect(page).to have_content(party.duration)
    expect(page).to have_content(party.day)
    expect(page).to have_content(party.start_time)

    expect(page).to have_content(party2.duration)
    expect(page).to have_content(party2.day)
    expect(page).to have_content(party2.start_time)
  end

  it 'can redirect a visitor if they try to visit the dashboard' do
    visit '/dashboard'

    expect(current_path).to eq('/')
    expect(page).to have_content('Must be a registered user and logged in to visit user dashboard.')


  end
end
