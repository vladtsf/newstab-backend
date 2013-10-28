class FeedController < ApplicationController
  def index
    @feed = Post.all(:order => "created_at desc", :limit => 30).map { |post| post.public_info }
    render json: @feed
  end
end
