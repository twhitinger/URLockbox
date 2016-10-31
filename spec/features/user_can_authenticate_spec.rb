require 'rails_helper'

RSpec.feature 'User can authenticate' do
  context 'Unauthenticated user' do
    scenario 'forced to login when visiting the root' do
      visit '/'

      expect(current_path).to eq('/login')

      within('#login-field') do
        expect(page).to have_field('E-mail')
        expect(page).to have_field('Password')
        expect(page).to have_field('Verify Password')
        expect(page).to have_link('Login')
        expect(page).to have_link('Sign Up')
      end
    end
  end
end
