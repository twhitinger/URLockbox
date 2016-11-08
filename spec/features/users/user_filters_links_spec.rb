require 'rails_helper'

RSpec.feature 'User filters links' do

  before(:each) do
    user = User.create!(email: 'test@example.com', password: 'pass')
    allow_any_instance_of(ApplicationController).
    to receive(:current_user).
    and_return(user)
    user.links.create!(title: 'Bingo', url: 'http://www.bingo.com')
    user.links.create!(
    title: 'Dance',
    url: 'http://www.prance.com',
    read: 'true'
    )
  end

  context 'authorized user with read and unread links', js: true do
    scenario 'they filter by links status' do
      visit '/'

      click_on 'Message Status'

      expect(page).to have_content('Bingo')
      expect(page).to have_link('http://www.bingo.com')
      expect(page).to_not have_content('Dance')
      expect(page).to_not have_link('http://www.prance.com')


      click_on 'Message Status'

      expect(page).to have_content('Dance')
      expect(page).to have_link('http://www.prance.com')
      expect(page).to_not have_content('Bingo')
      expect(page).to_not have_link('http://www.bingo.com')

    end
  end
end
