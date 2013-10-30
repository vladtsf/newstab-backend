class FeedController < ApplicationController
  def index
    limit = ( params[:limit] || 30 ).to_i
    offset = ( params[:offset] || 0 ).to_i

    @feeds_count = FeedSource.count

    @feed = FeedSource.all.map do |source|
      source.posts
        .order("extract (minute from created_at) desc")
        .order('index_in_feed asc')
        .offset(offset)
        .limit limit / @feeds_count
    end

    render json: {  :offset => offset,
                    :limit => limit,
                    :total => Post.count,
                    :items => @feed
                      .flatten
                      .map { |post| post.public_info } }
  end
end
