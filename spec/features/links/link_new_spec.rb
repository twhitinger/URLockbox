require 'rails_helper'

RSpec.feature 'Link creation' do

  before(:each) do
    user = User.create!(email: 'pizza@example.com', password: 'pizza')
    allow_any_instance_of(ApplicationController).
    to receive(:current_user).
    and_return(user)
  end

  context 'authenticated user' do
    context 'valid parameters' do
      scenario 'no tags' do
        expect(Link.count).to eq(0)

        visit '/'

        fill_in 'Url', with: 'http://www.shat.com'
        fill_in 'Title', with: 'shat'
        click_on 'Submit'


        expect(page).to have_content("Link to shat added to your repo.")
        expect(Link.count).to eq(1)
        expect(page).to have_link('http://www.shat.com')
      end



      scenario 'with a tag' do
        expect(Link.count).to eq(0)

        visit '/'

        fill_in 'Url', with: 'http://www.shat.com'
        fill_in 'Title', with: 'shat'
        fill_in 'Tag list', with: 'shatter'
        click_on 'Submit'


        expect(page).to have_content("Link to shat added to your repo.")
        expect(Link.count).to eq(1)
        expect(page).to have_link('http://www.shat.com')
        expect(page).to have_link('shatter')

      end

      scenario 'mas tags' do
        expect(Link.count).to eq(0)

        visit '/'


        fill_in 'Url', with: 'http://www.shat.com'
        fill_in 'Title', with: 'shat'
        fill_in 'Tag list', with: 'smoke, WEED, Everyday'
        click_on 'Submit'

        expect(page).to have_content("Link to shat added to your repo.")
        expect(Link.count).to eq(1)

        expect(page).to have_link('http://www.shat.com')
        expect(page).to have_link('smoke')
        expect(page).to have_link('weed')
        expect(page).to have_link('everyday')
      end
    end

    context 'wrong parameters' do
      scenario 'with invalid Url' do
        visit '/'


        fill_in 'Url', with: 'holy hell this is repetive as fuck'
        fill_in 'Title', with: 'hell'
        click_on 'Submit'


        expect(Link.count).to eq(0)
        expect(page).to have_content('Link must be valid format and all inputs filled in')
      end

      scenario 'with missing Title' do
        visit '/'


        fill_in 'Url', with: 'http://www.emptyinside.com'
        click_on 'Submit'

        expect(Link.count).to eq(0)
        expect(page).to have_content("Link must be valid format and all inputs filled in")
      end
    end
  end
end
