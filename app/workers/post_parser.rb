class PostParser < ApplicationController
  include Sidekiq::Worker
  include Magick

  sidekiq_options queue: "post", retry: false

  def perform(source_id, idx, post_url)
    unless Post.find_by_href post_url
      @post = OpenGraph.fetch(post_url)

      begin
        @image = ImageList.new(@post.image)
      rescue Exception => e

      else
        @image_file = Tempfile.new "#{ (Time.now.to_f * 1000 ).floor }.jpg"

        @image.resize_to_fit! 0, 250
        @image.write @image_file.path

        Post.create(  :feed_source_id => source_id,
                      :title => @post.title,
                      :image_src => @image_file,
                      :image_width => @image.columns,
                      :image_height => @image.rows,
                      :index_in_feed => idx,
                      :href => post_url )
      end
    end
  end
end