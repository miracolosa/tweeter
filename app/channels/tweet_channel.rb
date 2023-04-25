class TweetChannel < ApplicationCable::Channel
  def subscribed
    stream_for 'tweet_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
