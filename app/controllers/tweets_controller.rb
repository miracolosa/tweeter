class TweetsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]

  def index
    @tweet = Tweet.new
    @tweets = Tweet.all.order(created_at: :desc)
  end

  def show
    @tweet = Tweet.find(params[:id])
    @comment = Comment.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    format_response
  end

  def destroy
    @tweet = current_user.tweets.find(params[:id])
    @tweet.destroy
  end

  def retweet
    @tweet = Tweet.find(params[:id])
    @retweet = current_user.tweets.new(tweet_id: @tweet.id)

    respond_to do |format|
      if @retweet.save
        format.turbo_stream
      else
        format.html { redirect_back_or_to fallback_location: @tweet, alert: "Could not retweet" }
      end
    end
  end

  private

  def format_response
    respond_to do |format|
      if @tweet.save
        format.turbo_stream
      else
        format.html do
          flash[:tweet_errors] = "Body can't be blank."
          redirect_to root_path
        end
      end
    end
  end

  def tweet_params
    params.require(:tweet).permit(:body, :tweet_id)
  end

end
