require 'rails_helper'

RSpec.feature 'User can authenticate' do
  context 'Unauthenticated user' do
    scenario 'forced to login when visiting the root' do
      visit '/'

      expect(current_path).to eq('/login')

      within('#login-field') do
        expect(page).to have_content('Email')
        expect(page).to have_content('Password')
        expect(page).to have_content('Verify password')
        expect(page).to have_link('Login')
        expect(page).to have_link('Sign Up')
      end
    end
  end
end
