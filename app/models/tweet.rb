class Tweet < ApplicationRecord
  belongs_to :user

  validates :body, presence: true, length: { maximum: 240 }

  def time_difference
    difference = Time.current - self.created_at
    if (difference / 1.hour).round > 24
      return self.created_at.strftime("%b %d, %Y")
    elsif (difference / 1.minute).round > 120
      return "#{(difference / 1.hour).round}h"
    else
      return "#{(difference / 1.minute).round}m"
    end
  end
end
