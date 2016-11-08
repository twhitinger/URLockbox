class Link < ApplicationRecord
  validates :url, :format => URI::regexp(%w(http https)), presence: true
  validates :title, presence: true
  belongs_to :user


end
