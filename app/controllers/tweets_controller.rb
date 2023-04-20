class TweetsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]

  def index
    @tweet = Tweet.new
    @tweets = Tweet.all.order(created_at: :asc)
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
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

  def destroy
  end

  private

  def tweet_params
    params.require(:tweet).permit(:body)
  end

end
