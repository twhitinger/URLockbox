require 'rails_helper'

RSpec.feature 'User can authenticate' do
  context 'Unauthenticated user' do
    scenario 'forced to login when visiting the root' do
      visit '/'

      expect(current_path).to eq('/login')

      within('#login-field') do
        expect(page).to have_content('Email')
        expect(page).to have_content('Password')
        expect(page).to have_button('Login')
      end

      expect(page).to have_link('Sign Up')
    end
  end

  scenario 'an account with valid information' do
    visit '/'
    click_on 'Sign Up'

    expect(current_path).to eq(new_user_path)

    within('#login-field') do
      fill_in 'Email', with: 'test@example.com'
      fill_in 'Password', with: 'maybe'
      fill_in 'Verify password', with: 'maybe'
      click_on 'Sign Up'
    end

    expect(current_path).to eq(links_path)
    expect(page).to have_content("Created Account, test@example.com!")
  end


  scenario 'cannot create an account with invalid information' do
    visit new_user_path

    within('#login-field') do
      fill_in 'Email', with: 'test@example.com'
      fill_in 'Password', with: 'muck'
      click_on 'Sign Up'
    end

    expect(current_path).to eq(new_user_path)
    expect(page).to have_content('Passwords must be the same')
  end
end
