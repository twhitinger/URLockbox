require 'rails_helper'

RSpec.describe Link, type: :model do
  it { should validate_presence_of :title }
  it { should have_db_column(:read).with_options(default: 'false') }
  it { should validate_presence_of :url }
  it { should belong_to :user }
  it { should have_many(:taggings).dependent(:destroy) }
  it { should have_many(:tags).through(:taggings) }

  it 'should not allow invalid URLs' do
    link = Link.new(url: 'fakeAF')
    expect(link.save).to eq(false)
  end

  it 'should provide comma-separated tag names' do
    user = User.create!(email: 'fudge.com', password: 'pass')
    tag_1 = Tag.create!(name: 'wall')
    tag_2 = Tag.create!(name: 'dong')
    link = Link.create!(
    url: 'http://www.mucas.com',
    title: 'mucas',
    user: user,
    tags: [tag_1, tag_2]
    )
    expect(link.tag_list).to eq('wall, dong')
  end
end
