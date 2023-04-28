class Tweet < ApplicationRecord
  belongs_to :user
  belongs_to :tweet, optional: true
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable

  validates :body, length: { maximum: 240 }, allow_blank: false, unless: :tweet_id

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

  def tweet_type
    if tweet_id? && body?
      'quote'
    elsif tweet_id?
      'retweet'
    else
      'tweet'
    end
  end
end
