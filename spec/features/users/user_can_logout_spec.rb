
require 'rails_helper'

RSpec.feature 'User can log out' do
  context 'auth  user' do
    scenario 'they log out from the root' do
      user = User.create!(email: 'truck@example.com', password: 'dank')

      visit '/'


      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'dank'
      click_on 'Login'

      click_on "Logout"

      expect(current_path).to eq(login_path)
      expect(page).to have_button("Login")
      expect(page).to_not have_link("Sign Out")
    end
  end
end
