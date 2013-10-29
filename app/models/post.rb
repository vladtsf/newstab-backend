class Post < ActiveRecord::Base
  belongs_to :feed_source
  has_attached_file :image_src, :default_url => "/images/missing.png"

  def image
    { :src => image_src.url, :width => image_width, :height => image_height }
  end

  def public_info
    { :id => id,
      :image => image,
      :title => title,
      # :index_in_feed => index_in_feed,
      # :created_at =>  created_at,
      # :source => feed_source.name,
      :href => href }
  end
end
