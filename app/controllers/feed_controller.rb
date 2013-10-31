class FeedController < ApplicationController
  def index
    limit = ( params[:limit] || 30 ).to_i
    offset = ( params[:offset] || 0 ).to_i

    @feeds_count = FeedSource.count

    @feed = Post
      .order('floor(extract (epoch from created_at) / 60) desc, index_in_feed asc')
      .offset(offset)
      .limit limit

    render json: {  :offset => offset,
                    :limit => limit,
                    :total => Post.count,
                    :items => @feed.map { |post| post.public_info } }
  end
end
