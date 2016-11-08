require 'rails_helper'

RSpec.feature 'Link update' do

  before(:each) do
    user = User.create!(email: 'test@example.com', password: 'pass')
    allow_any_instance_of(ApplicationController).
    to receive(:current_user).
    and_return(user)
    tag = Tag.create!(name: 'hello')
    @link = user.links.create!(
    title: 'Google',
    url: 'http://www.google.com',
    tags: [tag]
    )
  end

  context 'user with links' do
    context 'valid parameters' do
      scenario 'they update a link title' do
        visit '/'

        click_on @link.tags.first.name

        expect(current_path).to eq(tag_path(@link.tags.first))
        click_on @link.title

        expect(current_path).to eq(edit_link_path(@link))

        fill_in 'Title', with: 'FUCK GOOGLE'
        click_on 'Update'
        expect(Link.first.title).to eq('FUCK GOOGLE')
        expect(page).to have_content('FUCK GOOGLE')
        expect(page).to have_content('hello')
        expect(page).to_not have_content('Google')
        expect(page).to have_link('http://www.google.com')

      end

      scenario 'they update a link Url' do
        visit '/'

        click_on 'Edit'
        expect(current_path).to eq(edit_link_path(@link))

        fill_in 'Url', with: 'http://speed.google.com'
        click_on 'Update'

        expect(current_path).to eq(links_path)
        expect(Link.first.url).to eq('http://speed.google.com')
        expect(page).to have_content('Google')
        expect(page).to have_content('hello')
        expect(page).to have_link('http://speed.google.com')
        expect(page).to_not have_link('http://www.google.com')
      end

      scenario 'they update a link title and Url' do
        visit '/'

        click_on 'Edit'
        expect(current_path).to eq(edit_link_path(@link))

        fill_in 'Title', with: 'Testing is wack'
        fill_in 'Url', with: 'http://drugs.google.com'
        click_on 'Update'

        expect(current_path).to eq(links_path)
        expect(Link.first.title).to eq('Testing is wack')
        expect(Link.first.url).to eq('http://drugs.google.com')
        expect(page).to have_content('Testing is wack')
        expect(page).to have_content('hello')
        expect(page).to have_link('http://drugs.google.com')
        expect(page).to_not have_content('Google')
        expect(page).to_not have_link('http://www.google.com')

      end

      scenario 'add a tag' do
        visit '/'

        click_on 'Edit'

        expect(current_path).to eq(edit_link_path(@link))

        fill_in 'Tag list', with: 'hello, goodbye'
        click_on 'Update'

        expect(current_path).to eq(links_path)
        expect(Link.first.title).to eq('Google')
        expect(Link.first.url).to eq('http://www.google.com')
        expect(Link.first.tags.first.name).to eq('hello')
        expect(Link.first.tags.second.name).to eq('goodbye')
        expect(page).to have_content('hello')
        expect(page).to have_content('goodbye')
        expect(page).to have_content('Google')
        expect(page).to have_link('http://www.google.com')

      end

      scenario 'remove a tag' do
        visit '/'

        click_on 'Edit'

        expect(current_path).to eq(edit_link_path(@link))

        fill_in 'Tag list', with: ''
        click_on 'Update'

        expect(current_path).to eq(links_path)
        expect(Link.first.title).to eq('Google')
        expect(Link.first.url).to eq('http://www.google.com')
        expect(Link.first.tags.count).to eq(0)

        expect(page).to_not have_content('hello')
        expect(page).to have_content('Google')
        expect(page).to have_link('http://www.google.com')

      end
    end

    context 'invalid parameters' do
      scenario 'with invalid Url' do
        visit '/'

        click_on 'Edit'

        fill_in 'Url', with: 'im fucking crazy.com'
        click_on 'Update'

        expect(current_path).to eq(links_path)
        expect(Link.first.title).to eq('Google')
        expect(Link.first.url).to eq('http://www.google.com')
        expect(page).to have_content('Url is invalid')
      end
    end
  end
end
