class CommentsController < ApplicationController
  before_action :set_tweet

  def create
    @comment = Comment.new(comment_params)
    @comment.tweet = @tweet
    @comment.user = current_user
    format_response
  end

  def destroy
    @comment = @tweet.comments.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.turbo_stream
      format.html do
        redirect_to tweet_path(@tweet), alert: "Comment could not be created"
      end
    end
  end

  private

  def format_response
    respond_to do |format|
      if @comment.save
        format.turbo_stream
      else
        format.html do
          flash[:tweet_errors] = "Body can't be blank."
          redirect_to tweet_path(@tweet)
        end
      end
    end
  end

  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

end
