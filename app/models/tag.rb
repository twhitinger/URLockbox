class Tag <  ApplicationRecord

  has_many :taggings
  has_many :links, through: :taggings
end
