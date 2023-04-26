class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :tweet

  validates :body, length: { maximum: 240 }, allow_blank: false
end
