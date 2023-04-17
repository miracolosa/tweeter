class TweetsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index ]

  def index
    @tweet = Tweet.new
  end

  def create
  end

  def destroy
  end
end
