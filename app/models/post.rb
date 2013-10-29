class Post < ActiveRecord::Base
  belongs_to :feed_source

  def image
    { :src => image_src, :width => image_width, :height => image_height }
  end

  def public_info
    { :id => id,
      :image => image,
      :title => title,
      # :created_at =>  created_at,
      # :source => feed_source.name,
      :href => href }
  end
end
