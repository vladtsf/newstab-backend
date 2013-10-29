class RemoveImageSrcFieldFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :image_src, :string
  end
end
