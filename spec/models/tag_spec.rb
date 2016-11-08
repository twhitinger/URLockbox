require 'rails_helper'

RSpec.describe Tag, type: :model do
  it { should have_many(:links).through(:taggings) }
  it { should have_many(:taggings) }
end
