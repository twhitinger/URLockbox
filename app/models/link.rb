class Link < ApplcationRecord
  validates :url, presense: true, url: true
  validates :title, presense: true
  belongs_to :user
end
