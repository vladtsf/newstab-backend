class PostParser < ApplicationController
  include Sidekiq::Worker
  include Magick

  sidekiq_options queue: "post", retry: true

  def perform(source_id, post_url)
    unless Post.find_by_href post_url
      @post = OpenGraph.fetch(post_url)
      @image = ImageList.new(@post.image)

      if @image.columns > 500
        @image.resize_to_fit! 500
      else
        @image.resize_to_fit! 200
      end

      Post.create(  :feed_source_id => source_id,
                    :title => @post.title,
                    :image_src => @post.image,
                    :image_width => @image.columns,
                    :image_height => @image.rows,
                    :href => post_url )
    end
  end
end