require 'rails_helper'

RSpec.feature 'User filters links by tag' do

  before(:each) do
    user = User.create!(email: 'test@example.com', password: 'test')

    allow_any_instance_of(ApplicationController).
    to receive(:current_user).
    and_return(user)

    tag_1 = Tag.create!(name: 'fuck')
    tag_2 = Tag.create!(name: 'me')

    @google_link = user.links.create!(
    title: 'Google',
    url: 'http://www.google.com',
    tags: [tag_1]
    )

    @fork_link = user.links.create!(
    title: 'Hi',
    url: 'http://www.fork.com',
    tags: [tag_2]
    )

    @no_tags_link = user.links.create!(
    title: 'No Tags',
    url: 'http://www.notags.com'
    )
  end

  context 'authorized user with tagged links', js: true do
    scenario 'they filter by a tag' do
      visit links_path

      click_on 'me'


      expect(page).to have_content(@fork_link.title)
      expect(page).to_not have_content(@no_tags_link.title)
      expect(page).to_not have_content(@google_link.title)

      click_on 'Home'

      click_on 'fuck'

      expect(page).to_not have_content(@fork_link.title)
      expect(page).to_not have_content(@no_tags_link.title)
      expect(page).to have_content(@google_link.title)

    end
  end
end
