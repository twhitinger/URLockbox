require 'rails_helper'

RSpec.describe 'Link deletion' do
  before(:each) do
    user = User.create!(email: 'tank@example.com', password: 'dunk')
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).
      and_return(user)
    tag = Tag.create!(name: 'fuck')
    @link = user.links.create!(
      title: 'Whipper',
      url: 'http://www.whippash.com',
      tags: [tag]
    )
  end

  context 'authorized user with links' do
    scenario 'they delete a link from the links page', js: true do
      visit links_path

      click_on 'fuck'
      click_on 'Delete'

      expect(Tag.count).to eq(1)
      expect(page).to_not have_content('Whipper')
      expect(page).to_not have_content('http://www.whippash.com')
      expect(Link.count).to eq(0)
    end
  end
end
