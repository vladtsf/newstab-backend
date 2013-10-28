class FeedController < ApplicationController
  def index
    limit = ( params[:limit] || 30 ).to_i
    offset = ( params[:offset] || 0 ).to_i

    @feeds_count = FeedSource.count

    @feed = FeedSource.all.map do |source|
      source.posts.order("created_at, image_width desc").offset(offset).limit limit / @feeds_count
    end

    render json: @feed.flatten.map { |post| post.public_info }
  end
end
