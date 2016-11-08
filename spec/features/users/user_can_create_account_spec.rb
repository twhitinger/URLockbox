require 'rails_helper'

RSpec.feature 'User creates an account' do
  context 'valid parameters' do
    scenario 'create an account' do
      visit '/'
      click_on 'Sign Up'

      expect(current_path).to eq(new_user_path)

      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'pass'
      fill_in 'Verify password', with: 'pass'
      click_on 'Sign Up'


      expect(current_path).to eq(links_path)
      expect(page).to have_content("Created Account, user@example.com!")
    end
  end

  context 'invalid parameters' do
    scenario 'with mismatched password' do
      visit new_user_path


      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'pass'
      fill_in 'Verify password', with: 'mismatched pass'
      click_on 'Sign Up'


      expect(current_path).to eq(new_user_path)
      expect(page).to have_content('Passwords must be the same')
    end

    scenario 'missing username' do
      visit new_user_path

      fill_in 'Password', with: 'pass'
      fill_in 'Verify password', with: 'pass'
      click_on 'Sign Up'


      expect(current_path).to eq(new_user_path)
      expect(page).to have_content("Form must be filled in or username taken")
    end

    scenario 'with taken username' do
      User.create!(email: 'taken@example.com', password: 'hello')

      visit new_user_path

      fill_in 'Email', with: 'taken@example.com'
      fill_in 'Password', with: 'pass'
      fill_in 'Verify password', with: 'pass'
      click_on 'Sign Up'


      expect(current_path).to eq(new_user_path)
      expect(page).to have_content("Form must be filled in or username taken")
    end
  end
end
