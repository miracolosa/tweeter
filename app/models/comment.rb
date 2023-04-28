class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :tweet
  has_many :likes, as: :likeable

  validates :body, length: { maximum: 240 }, allow_blank: false

  def time_difference
    difference = Time.current - self.created_at
    if (difference / 1.hour).round > 24
      return self.created_at.strftime("%b %d, %Y")
    elsif (difference / 1.minute).round > 60
      return "#{(difference / 1.hour).round}h"
    else
      return "#{(difference / 1.minute).round}m"
    end
  end
end
