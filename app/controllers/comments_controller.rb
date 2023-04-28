class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @tweet = Tweet.find(params[:tweet_id])
    @comment.tweet = @tweet
    @comment.user = current_user
    format_response
  end

  def destroy
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

  def comment_params
    params.require(:comment).permit(:body)
  end

end
