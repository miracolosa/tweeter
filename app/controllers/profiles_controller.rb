class ProfilesController < ApplicationController
  def show
    @profile = User.find(params[:id])
    @tweets = @profile.tweets.order(created_at: :desc)
  end
end
