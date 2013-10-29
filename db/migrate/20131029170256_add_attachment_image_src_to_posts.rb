class AddAttachmentImageSrcToPosts < ActiveRecord::Migration
  def self.up
    change_table :posts do |t|
      t.attachment :image_src
    end
  end

  def self.down
    drop_attached_file :posts, :image_src
  end
end
