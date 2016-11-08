require 'rails_helper'

RSpec.feature 'User searches for links' do

  before(:each) do
    user = User.create!(email: 'test@example.com', password: 'test')
    allow_any_instance_of(ApplicationController).
    to receive(:current_user).
    and_return(user)
    tag = Tag.create!(name: 'search')
    user.links.create!(
    title: 'Monkey',
    url: 'http://www.google.com',
    tags: [tag]
    )
    user.links.create!(
    title: 'Tiger',
    url: 'http://www.bing.com',
    tags: [tag]
    )
  end

  context 'authorized user with links' do
    scenario 'they search for a link by name', js: true do
      visit '/'

      fill_in 'search-bar', with: 'monkey'


      expect(page).to have_content('Monkey')
      expect(page).to_not have_content('Tiger')

    end

    scenario 'they search for a link by URL', js: true do
      visit '/'

      fill_in 'search-bar', with: 'tiger'


        expect(page).to_not have_content('Monkey')
        expect(page).to have_content('Tiger')
    end

    scenario 'they search for a link by tag name', js: true do
      visit '/'

      fill_in 'search-bar', with: 'search'

      within('#links') do
        expect(page).to have_content('Tiger')
        expect(page).to have_content('Monkey')
      end
    end
  end
end
