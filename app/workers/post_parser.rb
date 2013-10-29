class PostParser < ApplicationController
  include Sidekiq::Worker
  include Magick

  sidekiq_options queue: "post", retry: true

  def perform(source_id, post_url)
    unless Post.find_by_href post_url
      @post = OpenGraph.fetch(post_url)
      @image = ImageList.new(@post.image)

      @image.resize_to_fit! 0, 250

      Post.create(  :feed_source_id => source_id,
                    :title => @post.title,
                    :image_src => @post.image,
                    :image_width => @image.columns,
                    :image_height => @image.rows,
                    :href => post_url )
    end
  end
end